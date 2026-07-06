import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/news_dto.dart';

import '../../domain/repositories/news_repository.dart';
import '../../domain/entities/news_article.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiClient _apiClient;

  NewsRepositoryImpl(this._apiClient);
  @override
  Future<List<NewsArticle>> getNews({
    required int page,
    required int pageSize,
  }) async {
    final response = await _apiClient.get(
      '/api/articles',
      queryParameters: {
        'populate': '*',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => NewsDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<NewsArticle> getArticle(String id) async {
    final response = await _apiClient.get(
      '/api/articles/$id',
      queryParameters: {'populate': '*'},
    );

    final data = response.data['data'] as Map<String, dynamic>;

    return NewsDto.fromJson(data).toDomain();
  }

  @override
  Future<Map<String, String>> getLikedArticles() async {
    final result = <String, String>{};
    var page = 1;

    while (true) {
      final response = await _apiClient.get(
        '/api/user-articles',
        queryParameters: {
          'populate': 'Article',
          'pagination[page]': page,
          'pagination[pageSize]': 50,
        },
      );

      final data = response.data['data'] as List<dynamic>;
      for (final e in data) {
        final entry = e as Map<String, dynamic>;
        final article = entry['Article'] as Map<String, dynamic>?;
        final articleId = article?['documentId'] as String?;
        if (articleId != null) {
          result[articleId] = entry['documentId'] as String;
        }
      }

      final pagination =
          response.data['meta']?['pagination'] as Map<String, dynamic>?;
      final pageCount = pagination?['pageCount'] as int? ?? 1;
      if (page >= pageCount) break;
      page++;
    }

    return result;
  }

  // @override
  // Future<String?> toggleLike(String newsId, [String? likeId]) async {
  //   if (likeId != null && likeId.isNotEmpty) {
  //     await _apiClient.delete('/api/user-articles/$likeId');
  //     return null;
  //   }

  //   final response = await _apiClient.post(
  //     '/api/user-articles',
  //     data: {
  //       'data': {'Article': newsId},
  //     },
  //   );

  //   final responseData = response.data['data'] ?? response.data;
  //   final returnedLikeId =
  //       responseData['documentId'] ?? responseData['id']?.toString();
  //   return returnedLikeId != null && returnedLikeId.toString().isNotEmpty
  //       ? returnedLikeId.toString()
  //       : null;
  // }

  // Future<String?> toggleLike(String newsId, [String? likeId]) async {
  //   print('--- TOGGLE LIKE START ---');
  //   print('Sending - newsId: $newsId, likeId: ${likeId ?? "null"}');

  //   // 1. UNLIKE PATHWAY
  //   if (likeId != null && likeId.isNotEmpty) {
  //     try {
  //       final response = await _apiClient.delete('/api/user-articles/$likeId');
  //       print('Unlike Success - Status: ${response.statusCode}');
  //       return null;
  //     } catch (e) {
  //       print('Unlike Failed: $e');
  //       rethrow;
  //     }
  //   }

  //   // 2. LIKE PATHWAY (Body payload sent to server)
  //   final payload = {
  //     'data': {'Article': newsId},
  //   };

  //   try {
  //     print('Sending Post Body: $payload');
  //     final response = await _apiClient.post(
  //       '/api/user-articles',
  //       data: payload,
  //     );
  //     print('Like Success - Raw Data: ${response.data}');

  //     final responseData = response.data['data'] ?? response.data;
  //     final returnedLikeId =
  //         responseData['documentId'] ?? responseData['id']?.toString();

  //     print('Extracted New Like ID: $returnedLikeId');
  //     return returnedLikeId?.toString();
  //   } catch (e) {
  //     print('Like Failed: $e');
  //     rethrow;
  //   }
  // }

   @override
  Future<String?> toggleLike(String albumId, [String? likeId]) async {
    if (likeId != null) {
      await _apiClient.delete('/api/user-articles/$likeId');
      return null;
    }

    final response = await _apiClient.post(
      '/api/user-articles',
      data: {
        'data': {'Article': albumId},
      },
    );
    return response.data['data']['documentId'] as String;
  }
}
