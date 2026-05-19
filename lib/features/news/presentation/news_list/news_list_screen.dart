import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/state/news_state.dart';
import 'package:go_sport/features/home/presentation/home/widgets/news_item.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/search_button.dart';
import 'widgets/news_list_screen_skeleton.dart';

class NewsListScreen extends ConsumerWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsStateProvider);

    return Scaffold(
      backgroundColor: DSColors.white,
      appBar: AppBar(
        backgroundColor: DSColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DSColors.black),
          onPressed: () => context.pop(),
        ),
        title: Text('News', style: context.h2),
        centerTitle: true,
        actions: [
          SearchButton(
            onTap: () {
              // TODO: открыть поиск
            },
          ),
        ],
      ),
      body: _buildBody(context, ref, newsState),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, NewsState state) {
    // Initial loading
    if (state.isLoading && state.articles.isEmpty) {
      return const NewsListScreenSkeleton();
    }

    // Error with no data
    if (state.error != null && state.articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error loading news', style: context.subtitleLSemi),
            const SizedBox(height: 8),
            Text(
              state.error!,
              style: context.textL?.copyWith(color: DSColors.gray60),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(newsStateProvider.notifier).loadNews();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final articles = state.articlesList;

    if (articles.isEmpty) {
      return const Center(child: Text('No news available'));
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(newsStateProvider.notifier).refresh(),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16, bottom: 100),
        itemCount: articles.length,
        separatorBuilder: (context, index) => const DottedDivider(),
        itemBuilder: (context, index) {
          final article = articles[index];
          return NewsItem(
            article: article,
            onTap: () => context.push('/news/${article.id}'),
          );
        },
      ),
    );
  }
}
