import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';

class ArtistsRepositoryMock implements ArtistsRepository {
  final List<Artist> _mockData = [
    Artist(
      id: '1',
      artistName: 'The Weeknd',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&h=300&fit=crop',
      isLiked: true,
      
    ),
    Artist(
      id: '2',
      artistName: 'Dua Lipa',
      imageUrl:
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=300&h=300&fit=crop',
      isLiked: true,
    ),
    Artist(
      id: '3',
      artistName: 'Imagine Dragons',
      imageUrl:
          'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=300&h=300&fit=crop',
      isLiked: false,
    ),
  ];

  @override
  Future<List<Artist>> getFeaturedArtists() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<({List<Artist> items, bool hasMore})> getFavoriteArtists({
    int page = 1,
    int pageSize = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final all = _mockData.where((e) => e.isLiked).toList();
    final total = all.length;
    final pageCount = total == 0 ? 1 : (total / pageSize).ceil();
    final start = (page - 1) * pageSize;
    if (start >= total) {
      return (items: <Artist>[], hasMore: false);
    }
    final end = (start + pageSize).clamp(0, total);
    return (
      items: all.sublist(start, end),
      hasMore: page < pageCount,
    );
  }

  @override
  Future<List<Album>> getArtistAlbums(String artistId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [];
  }

  @override
  Future<String?> toggleLike(String artistId, [String? likeId]) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (likeId != null) return null;
    return 'mock-like-id';
  }
}
