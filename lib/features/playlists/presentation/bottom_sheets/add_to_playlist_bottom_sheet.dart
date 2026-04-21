import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/bottom_sheet_container.dart';
import 'package:go_sport/domain/entities/track.dart';

import 'add_to_playlist_controller.dart';
import 'create_playlist.dart'; // Предполагаем, что этот файл существует для создания

void showAddToPlaylistBottomSheet({
  required BuildContext context,
  required Track track,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => _AddToPlaylistBottomSheet(track: track),
  );
}

class _AddToPlaylistBottomSheet extends ConsumerWidget {
  final Track track;

  const _AddToPlaylistBottomSheet({required this.track});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addToPlaylistControllerProvider(track));
    final notifier = ref.read(addToPlaylistControllerProvider(track).notifier);

    final topPadding = MediaQuery.paddingOf(context).top;
    
    // Кнопка Save активна только если мы не в процессе сохранения
    // и если что-то реально изменилось (добавлено или удалено)
    final hasChanges =
        state.selectedIds.difference(state.initialSelectedIds).isNotEmpty ||
        state.initialSelectedIds.difference(state.selectedIds).isNotEmpty;
    final canSave = !state.isSaving && hasChanges;

    return BottomSheetContainer(
      height: MediaQuery.of(context).size.height - topPadding - 24,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Шапка: Cancel - My Playlists - Save
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text('My Playlists', style: context.h2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: state.isSaving ? null : () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: context.subtitleM?.copyWith(
                          color: state.isSaving ? DSColors.gray40 : DSColors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: canSave
                          ? () async {
                              final success = await notifier.save();
                              if (success && context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          : null,
                      child: state.isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: DSColors.blue,
                              ),
                            )
                          : Text(
                              'Save',
                              style: context.subtitleM?.copyWith(
                                color: canSave ? DSColors.blue : DSColors.gray40,
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Кнопка "+ Create a playlist"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Пока заглушка
                  debugPrint('Create playlist stub');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: DSColors.blue.withValues(alpha: 0.05),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100), // Овальная по макету
                  ),
                ),
                icon: const Icon(Icons.add, color: DSColors.blue, size: 20),
                label: Text(
                  'Create a playlist',
                  style: context.subtitleLBold?.copyWith(color: DSColors.blue),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Показываем ошибку, если есть
          if (state.error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                state.error!,
                style: context.bodyL?.copyWith(color: DSColors.errorColor),
                textAlign: TextAlign.center,
              ),
            ),

          // Список плейлистов
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.playlists.isEmpty
                    ? Center(
                        child: Text(
                          'No custom playlists found',
                          style: context.bodyL?.copyWith(color: DSColors.gray60),
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.playlists.length,
                        padding: const EdgeInsets.only(bottom: 24),
                        itemBuilder: (context, index) {
                          final playlist = state.playlists[index];
                          final isSelected = state.selectedIds.contains(playlist.id);

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: _PlaylistSelectionTile(
                              playlist: playlist,
                              isSelected: isSelected,
                              onTap: state.isSaving
                                  ? null
                                  : () => notifier.toggle(playlist.id),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _PlaylistSelectionTile extends StatelessWidget {
  final Playlist playlist;
  final bool isSelected;
  final VoidCallback? onTap;

  const _PlaylistSelectionTile({
    required this.playlist,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          // Обложка плейлиста
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DSRadius.s),
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
              borderRadius: BorderRadius.circular(DSRadius.s),
              child: Image.asset(
                playlist.imageUrl, // Кастомные плейлисты используют локальные ассеты
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(width: 50, height: 50, color: DSColors.gray20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Название и бейджик треков
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  playlist.title,
                  style: context.subtitleM,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Оранжевый бейджик как в PlaylistTile
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: DSColors.orange.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(DSRadius.m),
                    border: Border.all(color: DSColors.orange.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    '${playlist.trackCount} track${playlist.trackCount != 1 ? 's' : ''}',
                    style: context.fieldLabel?.copyWith(color: DSColors.orange),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Чекбокс
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isSelected ? DSColors.blue : DSColors.white,
              border: Border.all(
                color: isSelected ? DSColors.blue : DSColors.gray20,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: DSColors.white, size: 16)
                : null,
          ),
        ],
      ),
    );
  }
}