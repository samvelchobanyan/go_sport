import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/bottom_sheet_container.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/user_profile/edit_profile/presentation/edit_profile/edit_profile_controller.dart';
import 'package:go_sport/domain/state/user_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

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

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: source,
      maxWidth: 1000, // Good practice to prevent massive uploads
      imageQuality: 85,
    );

    if (image == null) return;

    // Camera photos store rotation in EXIF metadata, not in the pixels. Flutter's
    // Image.file honors that tag (preview looks fine), but the server strips EXIF
    // on re-encode, so the saved avatar ends up sideways. Bake the orientation
    // into the pixels (and drop the tag) before the file reaches upload.
    final corrected = await _bakeOrientation(File(image.path));

    if (!mounted) return;
    setState(() {
      _selectedImageFile = corrected;
    });
  }

  Future<File> _bakeOrientation(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return file;

      final oriented = img.bakeOrientation(decoded);
      final jpg = img.encodeJpg(oriented, quality: 85);

      final target = File(
        '${file.parent.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await target.writeAsBytes(jpg);
      return target;
    } catch (_) {
      // Any decode/encode failure → fall back to the original file; a possibly
      // rotated avatar beats a broken picker.
      return file;
    }
  }

  void _showImageSourceSheet() {
    Widget sourceRow({
      required Widget icon,
      required String label,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: DSSpacing.s8),
          child: Row(
            children: [
              icon,
              const SizedBox(width: DSSpacing.s12),
              Text(label, style: context.subtitleM),
            ],
          ),
        ),
      );
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: DSColors.transparent,
      builder: (sheetContext) => BottomSheetContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sourceRow(
              icon: SvgPicture.asset(
                'assets/icons/camera.svg',
                width: DSIconSize.s24,
                height: DSIconSize.s24,
                colorFilter: const ColorFilter.mode(
                  DSColors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Take a photo',
              onTap: () {
                Navigator.pop(sheetContext);
                _pickImage(ImageSource.camera);
              },
            ),
            sourceRow(
              icon: const Icon(
                Icons.photo_library_outlined,
                size: DSIconSize.s24,
                color: DSColors.black,
              ),
              label: 'Choose from gallery',
              onTap: () {
                Navigator.pop(sheetContext);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
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
        backgroundColor: DSColors.blue10,
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
            const SizedBox(width: DSSpacing.s8),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // Top section with Avatar
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: DSSpacing.l),
                  GestureDetector(
                    onTap: _showImageSourceSheet,
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
                                            imageUrl: userState.user!.avatar!,
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
                  const SizedBox(height: DSSpacing.s40),
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
                  padding: const EdgeInsets.all(DSSpacing.m),
                  child: Column(
                    children: [
                      CustomInput(label: 'Name', controller: _nameController),
                      const SizedBox(height: DSSpacing.m),
                      CustomInput(
                        label: 'Surname',
                        controller: _surnameController,
                      ),

                      const Spacer(),

                      SafeArea(
                        top: false,
                        left: false,
                        right: false,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DSColors.blue,
                              padding: const EdgeInsets.symmetric(
                                vertical: DSSpacing.s14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xxl,
                                ),
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
                                : SvgPicture.asset(
                                    'assets/icons/check_lime.svg',
                                  ),
                            label: Text(
                              editState.isLoading ? "Saving..." : "Save",
                              style: context.subtitleLBold?.copyWith(
                                color: DSColors.lime,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: DSSpacing.s12),
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
