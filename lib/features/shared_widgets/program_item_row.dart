import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_up.dart';

class ProgramItemRow extends StatefulWidget {
  final String imageUrl;
  final String title;
  final int episodeCount;
  final VoidCallback onTap;
  final VoidCallback onIconTap;

  const ProgramItemRow({
    required this.imageUrl,
    required this.title,
    required this.episodeCount,
    required this.onTap,
    required this.onIconTap,
    super.key,
  });

  @override
  State<ProgramItemRow> createState() => _ProgramItemRowState();
}

class _ProgramItemRowState extends State<ProgramItemRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Thumbnail image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            // Title and episode count badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: context.subtitleM,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Episode count badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: DSColors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${widget.episodeCount} episode${widget.episodeCount != 1 ? 's' : ''}',
                      style: context.fieldLabel?.copyWith(
                        color: DSColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Right icon button
            GestureDetector(
              onTap: () {
                widget.onIconTap();
                showItemOptionsBottomSheet(
                  context: context,
                  imageUrl: widget.imageUrl,
                  title: widget.title,
                  subtitle: null,
                );
              },
              child: SvgPicture.asset(
                'assets/icons/edition_dots.svg',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
