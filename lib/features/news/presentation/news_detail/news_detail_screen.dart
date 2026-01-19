import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'news_detail_controller.dart';

class NewsDetailScreen extends ConsumerWidget {
  final String articleId;

  const NewsDetailScreen({
    super.key,
    required this.articleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newsDetailControllerProvider(articleId));

    return Scaffold(
      backgroundColor: DSColors.white,
      body: state.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: DSColors.blue),
        ),
        error: (message) => Scaffold(
          appBar: AppBar(
            backgroundColor: DSColors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: DSColors.black),
              onPressed: () => context.pop(),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error loading article',
                  style: context.subtitleLSemi,
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: context.textL?.copyWith(color: DSColors.gray60),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(newsDetailControllerProvider(articleId).notifier).load();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (article) => Scaffold(
          appBar: AppBar(
            backgroundColor: DSColors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: DSColors.black),
              onPressed: () => context.pop(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '— ${article.author}',
                    style: context.bodyL?.copyWith(
                      color: DSColors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 16),

              // Изображение
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    article.imageUrl,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: DSColors.divider,
                      width: double.infinity,
                      height: 240,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Заголовок
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  article.title,
                  style: context.h2,
                ),
              ),
              const SizedBox(height: 16),

              // Subtitle (цитата)
              if (article.subtitle != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: DSColors.blue,
                          width: 3,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      article.subtitle!,
                      style: context.bodyL?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: DSColors.gray60,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Контент
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  article.content,
                  style: context.bodyL?.copyWith(height: 1.6),
                ),
              ),
              const SizedBox(height: 32),

              // Нижние кнопки
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    // Like button
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(newsDetailControllerProvider(articleId).notifier)
                            .toggleLike();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: DSColors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          article.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                          color: DSColors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Share button
                    GestureDetector(
                      onTap: () {
                        // Share functionality - будет реализовано позже
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: DSColors.divider,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.share_outlined,
                          color: DSColors.black,
                          size: 24,
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Likes counter
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: DSColors.divider, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 16,
                            color: DSColors.blue,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${article.likesCount}',
                            style: context.bodyL?.copyWith(
                              color: DSColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120), // Пространство для MiniPlayer и BottomNav
            ],
          ),
        ),
      ),
      ),
    );
  }
}
