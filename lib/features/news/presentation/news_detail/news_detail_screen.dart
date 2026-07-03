import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/news_article.dart';
import 'package:go_sport/domain/state/news_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'widgets/news_detail_screen_skeleton.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends ConsumerWidget {
  final String articleId;

  const NewsDetailScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsStateProvider);
    final article = newsState.getArticle(articleId);

    // If article not in cache, try to load it
    if (article == null) {
      // Trigger load if not already loading
      if (!newsState.isLoading) {
        Future.microtask(() {
          ref.read(newsStateProvider.notifier).loadArticle(articleId);
        });
      }
      return Scaffold(
        backgroundColor: DSColors.white,
        body: const NewsDetailScreenSkeleton(),
      );
    }

    return _buildContent(context, ref, article);
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    NewsArticle article,
  ) {
    return Scaffold(
      backgroundColor: DSColors.white,
      appBar: AppBar(
        backgroundColor: DSColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DSColors.black),
          onPressed: () => context.canPop() ? context.pop() : context.go('/'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: DSSpacing.m),
            child: Align(
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  final parts = article.author.split(' ');
                  final firstName = parts.isNotEmpty ? parts[0] : '';
                  final lastName = parts.length > 1
                      ? parts.sublist(1).join(' ')
                      : '';
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: DSSpacing.s6),
                      //   child:
                      Container(width: 14, height: 2, color: DSColors.orange),
                      // ),
                      const SizedBox(width: DSSpacing.s8),
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
            const SizedBox(height: DSSpacing.s8),

            // Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.s),
                child: DSNetworkImage(
                  imageUrl: article.imageUrl,
                  width: double.infinity,
                  height: 240,
                ),
              ),
            ),
            const SizedBox(height: DSSpacing.s14),

            // Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
              child: Text(
                DateFormat('MMM d, yyyy').format(article.publishedAt),
                style: context.label?.copyWith(color: DSColors.gray60),
              ),
            ),
            const SizedBox(height: DSSpacing.s8),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
              child: Text(article.title, style: context.h2),
            ),
            const SizedBox(height: DSSpacing.m),

            // Subtitle (quote)
            if (article.subtitle != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: DSColors.blue, width: 3),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: DSSpacing.m),
                  child: Text(
                    article.subtitle!,
                    style: context.subtitleM?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: DSColors.gray60,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DSSpacing.m),
            ],

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
              child: Text(
                article.content,
                style: context.bodyL?.copyWith(height: 1.6),
              ),
            ),
            const SizedBox(height: DSSpacing.m),

            // Divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: DSSpacing.l),
              child: DottedDivider(),
            ),
            const SizedBox(height: DSSpacing.m),

            // Bottom buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
              child: Row(
                children: [
                  // Like button
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(newsStateProvider.notifier)
                          .toggleLike(article.id);
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: article.isLiked ? DSColors.blue : DSColors.white,
                        shape: BoxShape.circle,
                        border: article.isLiked
                            ? Border.all(color: DSColors.blue, width: 1)
                            : Border.all(color: DSColors.blue20, width: 1),
                      ),
                      child: SvgPicture.asset(
                        article.isLiked
                            ? 'assets/icons/thumb_up_outlined.svg'
                            : 'assets/icons/thumb_up.svg',
                        width: DSIconSize.s24,
                        height: DSIconSize.s24,
                      ),
                    ),
                  ),
                  const SizedBox(width: DSSpacing.m),

                  // Share button — functionality not implemented yet, hidden for now.
                  // GestureDetector(
                  //   onTap: () {
                  //     // Share functionality - will be implemented later
                  //   },
                  //   child: Container(
                  //     width: 48,
                  //     height: 48,
                  //     decoration: BoxDecoration(
                  //       color: DSColors.blue10,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: Icon(
                  //       Icons.share_outlined,
                  //       color: DSColors.blue,
                  //       size: DSIconSize.s24,
                  //     ),
                  //   ),
                  // ),
                  const Spacer(),

                  // Likes counter
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: DSColors.blue20, width: 1),
                      borderRadius: BorderRadius.circular(DSRadius.s),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/thumb_up.svg',
                          width: DSIconSize.s20,
                        ),
                        const SizedBox(width: DSSpacing.s6),
                        Text(
                          '${article.likesCount}',
                          style: context.bodyL?.copyWith(
                            color: DSColors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DSSpacing.s20),
          ],
        ),
      ),
    );
  }
}
