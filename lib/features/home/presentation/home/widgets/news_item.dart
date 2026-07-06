import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/news_article.dart';
import 'package:intl/intl.dart';

class NewsItem extends StatelessWidget {
  final NewsArticle article;
  final VoidCallback onTap;

  const NewsItem({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DSRadius.s),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DSSpacing.s8,
          horizontal: DSSpacing.m,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение новости
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.s),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.s),
                child: DSNetworkImage(
                  imageUrl: article.imageUrl,
                  width: 84,
                  height: 84,
                ),
              ),
            ),
            const SizedBox(width: DSSpacing.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: DSSpacing.s),

                  Text(
                    DateFormat('MMM d, yyyy').format(article.publishedAt),
                    style: context.label?.copyWith(color: DSColors.gray60),
                  ),
                  SizedBox(height: DSSpacing.xs),

                  Text(
                    article.title,
                    style: context.subtitleM,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Текстовая информация
          ],
        ),
      ),
    );
  }
}
