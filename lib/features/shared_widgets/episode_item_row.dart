import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_up.dart';

class EpisodeItemRow extends StatefulWidget {
  final String imageUrl;
  final String title;
  final DateTime? releaseDate;
  final Duration? duration;
  final VoidCallback onTap;
  final VoidCallback onIconTap;

  const EpisodeItemRow({
    required this.imageUrl,
    required this.title,
    this.releaseDate,
    this.duration,
    required this.onTap,
    required this.onIconTap,
    super.key,
  });

  @override
  State<EpisodeItemRow> createState() => _EpisodeItemRowState();
}

class _EpisodeItemRowState extends State<EpisodeItemRow> {
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()}w ago';
    } else {
      return '${(diff.inDays / 30).floor()}m ago';
    }
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return '';
    final totalMinutes = duration.inMinutes;
    if (totalMinutes < 60) {
      return '${totalMinutes}m';
    } else {
      final hours = totalMinutes ~/ 60;
      final mins = totalMinutes % 60;
      return '${hours}h ${mins}m';
    }
  }

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
            // Title and date/duration row
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
                  Row(
                    children: [
                      if (widget.releaseDate != null)
                        Text(
                          _formatDate(widget.releaseDate),
                          style: context.subtitleLSemi?.copyWith(
                            color: DSColors.gray60,
                          ),
                        ),
                      if (widget.releaseDate != null && widget.duration != null)
                        Text(
                          ' • ',
                          style: context.subtitleLSemi?.copyWith(
                            color: DSColors.gray60,
                          ),
                        ),
                      if (widget.duration != null)
                        Text(
                          _formatDuration(widget.duration),
                          style: context.subtitleLSemi?.copyWith(
                            color: DSColors.gray60,
                          ),
                        ),
                    ],
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
