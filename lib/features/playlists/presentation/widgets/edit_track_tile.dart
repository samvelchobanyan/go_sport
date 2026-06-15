import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';

class EditTrackTile extends StatelessWidget {
  final Track track;
  final VoidCallback onDelete;
  final int index;
  final double topPadding;

  const EditTrackTile({
    super.key,
    required this.track,
    required this.onDelete,
    required this.index,
    this.topPadding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Убираем вертикальный padding, он будет компенсироваться контейнером ReorderableListView,
      // или добавляем его так же как в TrackTile (vertical: 12)
      padding: EdgeInsets.only(left: DSSpacing.m, right: DSSpacing.m, top: topPadding, bottom: DSSpacing.s8),
      child: Row(
        children: [
          // Кнопка удаления (Оранжевый круг с прозрачностью 10%)
          GestureDetector(
            onTap: onDelete,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: DSColors.orange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/delete.svg', // или icon из макета
                  width: 16,
                  height: 16,
                  // Принудительно красим в оранжевый, если оригинал другой
                  colorFilter: const ColorFilter.mode(
                    DSColors.orange,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: DSSpacing.s12),

          // Обложка трека (Такая же как в TrackTile)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DSRadius.xs),
              boxShadow: [
                BoxShadow(
                  color: DSColors.black.withValues(alpha: 0.7),
                  blurRadius: 6,
                  spreadRadius: -2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DSRadius.xs),
              child: track.imageUrl != null
                  ? Image.network(
                      track.imageUrl!,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(width: 48, height: 48, color: DSColors.gray20),
                    )
                  : Container(width: 48, height: 48, color: DSColors.gray20),
            ),
          ),
          const SizedBox(width: DSSpacing.s10),

          // Инфо трека
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  track.title,
                  style: context.subtitleM?.copyWith(
                    color: DSColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: DSSpacing.s),
                Text(
                  track.artistName,
                  style: context.textL?.copyWith(color: DSColors.gray60),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: DSSpacing.s10),

          // Drag Handle (Гамбургер / 3 полоски прямо из material icons)
          ReorderableDragStartListener(
            index: index,
            child: Padding(
              padding: const EdgeInsets.all(DSSpacing.s8),
              child: Icon(
                Icons.menu,
                color: DSColors.black,
                size: DSIconSize.s24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
