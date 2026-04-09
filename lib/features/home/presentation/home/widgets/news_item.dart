import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/news_article.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Изображение новости
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.s),
                boxShadow: [
                  BoxShadow(
                    color: DSColors.black.withValues(alpha: 0.20),
                    offset: const Offset(3, 6),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.s),
                child: Hero(
                  tag: 'newsImage:${article.id}',
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 84,
                      height: 84,
                      color: DSColors.divider,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 84,
                      height: 84,
                      color: DSColors.gray20,
                      child: const Icon(
                        Icons.error,
                        color: DSColors.gray50,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 11),
            // Текстовая информация
            Expanded(
              child: Text(
                article.title,
                style: context.subtitleM,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
