import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/user_profile/edit_profile/presentation/edit_profile/edit_profile_controller.dart';
import 'package:go_sport/domain/state/user_state.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  File? _selectedImageFile;

  Widget _buildPlaceholder() {
    return Container(
      color: DSColors.gray20,
      child: const Icon(Icons.person, color: DSColors.gray60),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Pick an image from gallery
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000, // Good practice to prevent massive uploads
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _selectedImageFile = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Get current data from the global user state if available
    final currentUser = ref.read(userStateProvider).user;
    _nameController = TextEditingController(text: currentUser?.name);
    _surnameController = TextEditingController(text: currentUser?.surname);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    await ref
        .read(editProfileControllerProvider.notifier)
        .updateUser(
          name: _nameController.text.trim(),
          surname: _surnameController.text.trim(),
          avatar: _selectedImageFile,
        );

    // After updating, refresh the global user data
    await ref.read(userStateProvider.notifier).getUser();

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final editState = ref.watch(editProfileControllerProvider);
    final userState = ref.watch(userStateProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.blue.withOpacity(0.1),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DSColors.black),
            onPressed: () => context.pop(),
          ),
          title: Text('Edit Profile', style: context.h2),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => {},
              icon: SvgPicture.asset('assets/icons/bell_blue.svg'),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // Top section with Avatar
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: DSColors.white, width: 12),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // The base avatar image
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: _selectedImageFile != null
                                  ? Image.file(
                                      _selectedImageFile!,
                                      fit: BoxFit.cover,
                                    )
                                  : (userState.user?.avatar != null
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                userState.user!.avatar!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                _buildPlaceholder(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    _buildPlaceholder(),
                                          )
                                        : _buildPlaceholder()),
                            ),
                          ),
                          // The Overlay
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: DSColors.gray30,
                            ),
                          ),

                          // The Camera/Edit Icon
                          SvgPicture.asset(
                            'assets/icons/camera.svg',
                            colorFilter: const ColorFilter.mode(
                              DSColors.white,
                              BlendMode.srcIn,
                            ),
                            width: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),

            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomInput(label: 'Name', controller: _nameController),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Surname',
                        controller: _surnameController,
                      ),

                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DSColors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(DSRadius.xl),
                            ),
                          ),
                          onPressed: editState.isLoading ? null : _onSave,
                          icon: editState.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : SvgPicture.asset('assets/icons/check_lime.svg'),
                          label: Text(
                            editState.isLoading ? "Saving..." : "Save",
                            style: context.subtitleLBold?.copyWith(
                              color: DSColors.lime,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
