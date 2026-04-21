import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_sport/features/shared_widgets/user_avatar_button.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Pick an image from gallery
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000, // Good practice to prevent massive uploads
      imageQuality: 85,
    );

    if (image != null) {
      // Pass the image path to your controller/notifier
      // Example: ref.read(profileControllerProvider.notifier).updateAvatar(image.path);
      print('Picked image path: ${image.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          const UserAvatarButton(imageUrl: null, size: 100),

                          // The Overlay
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.3),
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
                      CustomInput(label: 'Name'),
                      const SizedBox(height: 16),
                      CustomInput(label: 'Surname'),

                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => {},
                          icon: SvgPicture.asset('assets/icons/check_lime.svg'),
                          label: Text(
                            "Save",
                            style: context.subtitleLBold?.copyWith(
                              color: DSColors.lime,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DSColors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(DSRadius.xl),
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
