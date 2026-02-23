import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class ArtistCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const ArtistCard({
    required this.name,
    required this.imageUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Colors.grey[300],
                  ),
                  child: const Icon(Icons.person),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 120,
            child: Text(
              name,
              style: context.subtitleM,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
