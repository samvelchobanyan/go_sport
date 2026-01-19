import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class UserAvatarButton extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onTap;
  final double size;

  const UserAvatarButton({
    super.key,
    this.imageUrl,
    this.onTap,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildPlaceholder(),
                  errorWidget: (context, url, error) => _buildPlaceholder(),
                )
              : _buildPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: DSColors.gray20,
      child: Icon(
        Icons.person,
        color: DSColors.gray50,
        size: size * 0.6,
      ),
    );
  }
}