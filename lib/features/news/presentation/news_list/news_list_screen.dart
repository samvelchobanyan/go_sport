import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/home/presentation/home/widgets/news_item.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'news_list_controller.dart';

class NewsListScreen extends ConsumerStatefulWidget {
  const NewsListScreen({super.key});

  @override
  ConsumerState<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends ConsumerState<NewsListScreen> {
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
      ref.read(newsListControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsListControllerProvider);

    return Scaffold(
      backgroundColor: DSColors.white,
      appBar: AppBar(
        backgroundColor: DSColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DSColors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'News',
          style: context.h2,
        ),
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
      body: state.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: DSColors.blue),
        ),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error loading news',
                style: context.subtitleLSemi,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: context.textL?.copyWith(color: DSColors.grey60),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(newsListControllerProvider.notifier).loadInitial();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (articles, hasMore, isLoadingMore) => ListView.separated(
          controller: _scrollController,
          padding: const EdgeInsets.only(top: 16, bottom: 100),
          itemCount: articles.length + (isLoadingMore ? 1 : 0),
          separatorBuilder: (context, index) => const DottedDivider(),
          itemBuilder: (context, index) {
            if (index >= articles.length) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(color: DSColors.blue),
                ),
              );
            }

            final article = articles[index];
            return NewsItem(
              article: article,
              onTap: () => context.push('/news/${article.id}'),
            );
          },
        ),
      ),
    );
  }
}
