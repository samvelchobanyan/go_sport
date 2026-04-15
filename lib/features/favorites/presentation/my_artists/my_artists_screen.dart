import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/features/favorites/presentation/my_artists/my_artists_controller.dart';
import 'package:go_sport/features/shared_widgets/artist_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';

class MyArtistsScreen extends ConsumerStatefulWidget {
  const MyArtistsScreen({super.key});

  @override
  ConsumerState<MyArtistsScreen> createState() => _MyArtistsScreenState();
}

class _MyArtistsScreenState extends ConsumerState<MyArtistsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final state = ref.read(myArtistsStateProvider);
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(myArtistsStateProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myArtistsStateProvider);
    final artists = state.artists;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 240,
              child: Image.asset(
                'assets/images/mine_cover.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                MyCategoriesHeader(
                  iconPath: 'assets/icons/dynamic_bg.svg',
                  title: 'My Artists',
                  subtitle: 'Artists',
                  itemCount: artists.length,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DSRadius.m),
                      topRight: Radius.circular(DSRadius.m),
                    ),
                    child: Container(
                      color: DSColors.white,
                      child: state.isLoading && artists.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state.error != null && artists.isEmpty
                          ? _buildErrorWidget(state)
                          : _buildArtistsList(ref, artists, state.isLoadingMore),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(MyArtistsState state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Failed to load favorite artists', style: context.subtitleLBold),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () =>
                ref.read(myArtistsStateProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistsList(
    WidgetRef ref,
    List<Artist> artists,
    bool isLoadingMore,
  ) {
    if (artists.isEmpty) {
      return Center(
        child: Text('No favorite artists yet', style: context.subtitleLBold),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(myArtistsStateProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: artists.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) {
          if (index >= artists.length - 1) {
            return const SizedBox.shrink();
          }

          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DottedDivider(),
          );
        },
        itemBuilder: (context, index) {
          if (index >= artists.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final artist = artists[index];

          return ClipRRect(
            borderRadius: index == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  )
                : BorderRadius.zero,
            child: Container(
              color: DSColors.white,
              child: ArtistTile(
                artist: artist,
              ),
            ),
          );
        },
      ),
    );
  }
}
