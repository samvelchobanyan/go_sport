import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/favorites/presentation/widgets/favorite_item_row.dart';
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
      backgroundColor: DSColors.white,
      appBar: AppBar(
        backgroundColor: DSColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DSColors.black),
          onPressed: () => context.pop(),
        ),
        title: Text('Favorites', style: context.h2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: DSColors.black),
            onPressed: () {
              // Search functionality - заглушка
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: ref.read(songRepositoryProvider).getFeaturedSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: DSColors.blue),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading favorites', style: context.subtitleLSemi),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: context.textL?.copyWith(color: DSColors.grey60),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No favorites yet', style: context.subtitleLBold),
            );
          }

          final songs = snapshot.data!;
          return ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 16, bottom: 100),
            itemCount: songs.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DottedDivider(),
            ),
            itemBuilder: (context, index) {
              final song = songs[index];
              return FavoriteItemRow(
                imageUrl: song.imageUrl ?? '',
                title: song.title,
                subtitle: song.artist,
                onTap: () {
                  // TODO: Navigate to song detail or player
                  debugPrint('Song tapped: ${song.id}');
                },
                onIconTap: () {
                  // TODO: Handle favorite icon tap (remove from favorites)
                  debugPrint('Favorite icon tapped for: ${song.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}
