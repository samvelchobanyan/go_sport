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
  Future<List<Album>> getFavoriteAlbums(
    //{ required int page,
    // required int pageSize, }
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData.where((p) => p.isLiked).toList();
  }

  @override
  Future<List<Track>> getAlbumTracks(String albumId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [];
  }

  @override
  Future<void> toggleLike(String albumId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // В реальном API здесь будет HTTP запрос
    // Состояние обновляется в domain state (optimistic update)
  }
}
  