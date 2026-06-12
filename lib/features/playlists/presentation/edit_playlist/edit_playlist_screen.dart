import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/playlists/presentation/playlist/custom_playlist_controller.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/delete_confirm.dart';
import 'package:go_sport/features/playlists/presentation/widgets/edit_track_tile.dart';

class EditPlaylistScreen extends ConsumerStatefulWidget {
  final Playlist playlist;
  final List<Track> tracks;

  const EditPlaylistScreen({
    super.key,
    required this.playlist,
    required this.tracks,
  });

  @override
  ConsumerState<EditPlaylistScreen> createState() => _EditPlaylistScreenState();
}

class _EditPlaylistScreenState extends ConsumerState<EditPlaylistScreen> {
  late List<Track> _editedTracks;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Делаем локальную копию переданных треков
    _editedTracks = List.from(widget.tracks);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final track = _editedTracks.removeAt(oldIndex);
      _editedTracks.insert(newIndex, track);
    });
  }

  void _onDeleteTrack(int index, Track track) {
    showDeleteConfirmBottomSheet(
      context: context,
      text: 'Are you sure you want to remove this track from the playlist?',
      onConfirm: () async {
        // 1. Моментально убираем из локального состояния (UI обновляется сразу)
        setState(() {
          _editedTracks.removeAt(index);
        });

        // 2. Отправляем удаление на сервер через основной контроллер
        final controller = ref.read(customPlaylistControllerProvider(widget.playlist.id).notifier);
        controller.removeTrack(track.id);
        await controller.save();
      },
    );
  }

  Future<void> _onSave() async {
    // Не сохраняем дважды
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      // 1. Обновляем порядок треков в глобальном стейте
      final controller = ref.read(customPlaylistControllerProvider(widget.playlist.id).notifier);
      controller.updateTracks(_editedTracks);
      
      // 2. Отправляем обновленный порядок на сервер
      await controller.save();
      
      if (mounted) {
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSColors.white,
      appBar: AppBar(
        backgroundColor: DSColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.opaque,
          child: const Icon(Icons.arrow_back, color: DSColors.black),
        ),
        title: Text(
          widget.playlist.title,
          style: context.h2?.copyWith(color: DSColors.black),
        ),
        actions: [
          _isSaving 
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: DSSpacing.s20),
                child: SizedBox(
                  width: 24, height: 24, 
                  child: CircularProgressIndicator(color: DSColors.blue, strokeWidth: 2),
                ),
              )
            : GestureDetector(
                onTap: _onSave,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/check_lime.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        DSColors.blue, // Красим вашу лаймовую иконку в брендовый синий цвет
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
      body: ReorderableListView.builder(
        // Обязательно отключаем дефолтные хэндлы, 
        // чтобы перетаскивалось только за наши гамбургеры в EditTrackTile
        buildDefaultDragHandles: false,
        padding: const EdgeInsets.only(top: DSSpacing.s8, bottom: DSSpacing.s40), // Немного отступов
        itemCount: _editedTracks.length,
        onReorder: _onReorder,
        itemBuilder: (context, index) {
          final track = _editedTracks[index];
          // У ReorderableListView каждый child ОБЯЗАН иметь уникальный key, 
          // иначе анимация сломается
          return EditTrackTile(
            key: ValueKey(track.id), // <- Важнейшая вещь для reorder
            track: track,
            index: index,
            onDelete: () => _onDeleteTrack(index, track),
          );
        },
      ),
    );
  }
}
