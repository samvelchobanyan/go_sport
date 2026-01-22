import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'news_detail_controller.dart';
import 'widgets/news_detail_screen_skeleton.dart';

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
        loading: () => const NewsDetailScreenSkeleton(),
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
                  child: Builder(
                    builder: (context) {
                      final parts = article.author.split(' ');
                      final firstName = parts.isNotEmpty ? parts[0] : '';
                      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Container(
                              width: 14,
                              height: 2,
                              color: DSColors.orange,
                            ),
                          ),
                          const SizedBox(width:2),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                firstName,
                                style: context.subtitleM?.copyWith(
                                  color: DSColors.gray60,
                                ),
                              ),
                              if (lastName.isNotEmpty)
                                Text(
                                  lastName,
                                  style: context.subtitleM?.copyWith(
                                    color: DSColors.gray60,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 8),

              // Изображение
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(DSRadius.s),
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
              const SizedBox(height: 14),

              // Заголовок
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  article.title,
                  style: context.h2,
                ),
              ),
              const SizedBox(height: 15),

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
                      style: context.subtitleM?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: DSColors.gray60,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],

              // Контент
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  article.content,
                  style: context.bodyL?.copyWith(height: 1.6),
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: DottedDivider(),
              ),
              const SizedBox(height: 16),

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
                        width: 48,
                        height: 48,
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
                        width: 48,
                        height: 48,
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
                        borderRadius: BorderRadius.circular(DSRadius.l),
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
              const SizedBox(height: 21), // Пространство для MiniPlayer и BottomNav
            ],
          ),
        ),
      ),
      ),
    );
  }
}
