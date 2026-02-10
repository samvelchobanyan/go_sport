import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/favorites/presentation/widgets/favorite_item_row.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'favorites_list_controller.dart';

class FavoritesListScreen extends ConsumerStatefulWidget {
  const FavoritesListScreen({super.key});

  @override
  ConsumerState<FavoritesListScreen> createState() =>
      _FavoritesListScreenState();
}

class _FavoritesListScreenState extends ConsumerState<FavoritesListScreen> {
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
      ref.read(favoritesListControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          FutureBuilder(
            future: ref.read(songRepositoryProvider).getFeaturedSongs(),
            builder: (context, snapshot) {
              final songCount = snapshot.hasData ? snapshot.data!.length : 0;
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  MyCategoriesTop(
                    iconPath: 'assets/icons/heart_bg.svg',
                    title: 'My Favorites',
                    subtitle: 'tracks',
                    itemCount: songCount,
                    onTapIcon: _playAll,
                  ),

                  // 🔹 Songs list
                  if (snapshot.connectionState == ConnectionState.waiting)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (snapshot.hasError)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error loading favorites',
                              style: context.subtitleLSemi,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snapshot.error.toString(),
                              style: context.textL?.copyWith(
                                color: DSColors.gray60,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => setState(() {}),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (!snapshot.hasData || snapshot.data!.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'No favorites yet',
                          style: context.subtitleLBold,
                        ),
                      ),
                    )
                  else
                    ..._buildSongsSliver(snapshot.data!),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _playAll() {
    // TODO: Implement play-all favorites behavior
    debugPrint('Play all favorites pressed');
  }

  List<Widget> _buildSongsSliver(List<dynamic> songs) {
    // Build children list: separators and items
    final children = <Widget>[];

    for (int i = 0; i < songs.length; i++) {
      if (i > 0) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DottedDivider(),
          ),
        );
      }
      final song = songs[i];
      children.add(
        FavoriteItemRow(
          imageUrl: song.imageUrl ?? '',
          title: song.title,
          subtitle: song.artist,
          onTap: () => debugPrint('Song tapped: ${song.id}'),
          onIconTap: () => debugPrint('Favorite icon tapped for: ${song.id}'),
        ),
      );
    }

    // Wrap in a single column inside a container
    return [
      SliverToBoxAdapter(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Container(
            color: DSColors.white,
            child: Column(children: children),
          ),
        ),
      ),
    ];
  }
}
