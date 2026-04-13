import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';

class AlbumsRepositoryMock implements AlbumsRepository {
  final List<Album> _mockData = [
    const Album(
      id: '1',
      title: 'Advanced Fitness Training',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      artist: 'John Carter',
      trackCount: 12,
      isLiked: true,
      releaseYear: '2011',
    ),
    const Album(
      id: '2',
      title: 'Nutrition Mastery',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      artist: 'Emma Stone',
      trackCount: 8,
      isLiked: true,
      releaseYear: '1985',
    ),
    const Album(
      id: '3',
      title: 'Mental Strength Program',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      artist: 'David Goggins',
      trackCount: 10,
      isLiked: false,
      releaseYear: '2020',
    ),
    const Album(
      id: '4',
      title: 'Recovery & Wellness',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      artist: 'Sarah Lee',
      trackCount: 6,
      isLiked: false,
      releaseYear: '2005',
    ),
    const Album(
      id: '5',
      title: 'Athletic Performance',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      artist: 'Michael Jordan',
      trackCount: 15,
      isLiked: false,
      releaseYear: '2020',
    ),
  ];

  @override
  Future<List<Album>> getFeaturedAlbums(
    //{ required int page,
    // required int pageSize, }
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<({List<Album> items, bool hasMore})> getFavoriteAlbums({
    int page = 1,
    int pageSize = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final all = _mockData.where((p) => p.isLiked).toList();
    final total = all.length;
    final pageCount = total == 0 ? 1 : (total / pageSize).ceil();
    final start = (page - 1) * pageSize;
    if (start >= total) {
      return (items: <Album>[], hasMore: false);
    }
    final end = (start + pageSize).clamp(0, total);
    return (
      items: all.sublist(start, end),
      hasMore: page < pageCount,
    );
  }

  @override
  Future<List<Track>> getAlbumTracks(String albumId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [];
  }

  @override
  Future<String?> toggleLike(String albumId, [String? likeId]) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (likeId != null) return null;
    return 'mock-like-id';
  }
}
  