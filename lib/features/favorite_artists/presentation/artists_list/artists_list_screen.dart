import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/features/favorite_artists/presentation/artists_list/artists_controller.dart';
import 'package:go_sport/features/shared_widgets/artist_item_row.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';

class FavoriteArtistsListScreen extends ConsumerStatefulWidget {
  const FavoriteArtistsListScreen({super.key});

  @override
  ConsumerState<FavoriteArtistsListScreen> createState() =>
      _FavoriteArtistsListScreenState();
}

class _FavoriteArtistsListScreenState
    extends ConsumerState<FavoriteArtistsListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(artistsStateProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(artistsStateProvider);
    final List<Artist> artists = state.favoriteArtists;
    final isLoading = state.isLoading && artists.isEmpty;

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(artistsStateProvider.notifier).refresh(),
              child: Stack(
                children: [
                  // 🔹 Background image (visible behind rounded list)
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

                  // 🔹 Foreground content
                  Column(
                    children: [
                      MyCategoriesHeader(
                        iconPath: 'assets/icons/dynamic_bg.svg',
                        title: 'My Artists',
                        subtitle: 'artists',
                        itemCount: artists.length,
                      ),

                      // 🔹 Episodes list
                      if (artists.isEmpty)
                        Center(
                          child: Text(
                            'No favorites yet',
                            style: context.subtitleLBold,
                          ),
                        )
                      else
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(DSRadius.m),
                              topRight: Radius.circular(DSRadius.m),
                            ),
                            child: Container(
                              color: DSColors.white,
                              child: ListView.separated(
                                controller: _scrollController,
                                itemCount:
                                    artists.length +
                                    (state.isLoadingMore ? 1 : 0),
                                separatorBuilder: (context, index) =>
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: DottedDivider(),
                                    ),
                                itemBuilder: (context, index) {
                                  if (index >= artists.length) {
                                    // bottom loading indicator
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
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
                                      child: ArtistItemRow(
                                        name: artist.artistName,
                                        imageUrl: artist.imageUrl,
                                      ),
                                    ),
                                  );
                                },
                              ),
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
}
