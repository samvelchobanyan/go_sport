import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/bottom_sheet_container.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/playlists/presentation/bottom_sheets/add_tracks_controller.dart';
import 'package:go_sport/features/playlists/presentation/widgets/add_track_tile.dart';

void showAddTracksBottomSheet({
  required BuildContext context,
  required void Function(List<Track> tracks) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    useSafeArea: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => _AddTracksSheet(onSave: onSave),
  );
}

class _AddTracksSheet extends ConsumerStatefulWidget {
  final void Function(List<Track> tracks) onSave;

  const _AddTracksSheet({required this.onSave});

  @override
  ConsumerState<_AddTracksSheet> createState() => _AddTracksSheetState();
}

class _AddTracksSheetState extends ConsumerState<_AddTracksSheet> {
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _searchController = TextEditingController();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(addTracksControllerProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTracksControllerProvider);
    final topPadding = MediaQuery.paddingOf(context).top;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: BottomSheetContainer(
        height: MediaQuery.of(context).size.height - topPadding - 24,
        padding: EdgeInsets.zero,
        child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text('Add Tracks', style: context.h2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: context.subtitleM?.copyWith(
                          color: DSColors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final tracks = ref
                            .read(addTracksControllerProvider.notifier)
                            .getSelectedTracks();
                        Navigator.pop(context);
                        if (tracks.isNotEmpty) {
                          widget.onSave(tracks);
                        }
                      },
                      child: Text(
                        'Save',
                        style: context.subtitleM?.copyWith(
                          color: DSColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: (value) =>
                  ref.read(addTracksControllerProvider.notifier).search(value),
              decoration: InputDecoration(
                hintText: 'Search tracks',
                filled: true,
                fillColor: const Color.fromRGBO(64, 74, 195, 0.07),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DSRadius.s),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      DSColors.blue,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Section title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                state.isSearchMode ? 'Search results' : 'Favorite tracks',
                style: context.subtitleLBold,
              ),
            ),
          ),

          // Tracks list
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.tracks.isEmpty
                    ? Center(
                        child: Text(
                          state.isSearchMode
                              ? 'No tracks found'
                              : 'No favorite tracks yet',
                          style: context.textL?.copyWith(
                            color: DSColors.gray50,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: state.tracks.length +
                            (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= state.tracks.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final track = state.tracks[index];
                          return AddTrackTile(
                            track: track,
                            isSelected: state.selectedTrackIds.contains(
                              track.id,
                            ),
                            onToggle: () => ref
                                .read(addTracksControllerProvider.notifier)
                                .toggleTrack(track.id),
                          );
                        },
                      ),
          ),
        ],
      ),
    ),
    );
  }

}
