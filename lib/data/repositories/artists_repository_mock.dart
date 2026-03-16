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
      albums: [
        Album(
          id: 'a1',
          artist: 'The Weeknd',
          title: 'After Hours',
          trackCount: 14,
          isLiked: true,
          imageUrl:
              'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop',
        ),
        Album(
          id: 'a2',
          title: 'Starboy',
          imageUrl:
              'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop',
          trackCount: 18,
          isLiked: false,
          artist: 'The Weeknd',
        ),
      ],
    ),
    Artist(
      id: '2',
      artistName: 'Dua Lipa',
      imageUrl:
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=300&h=300&fit=crop',
      isLiked: true,

      albums: [
        Album(
          id: 'a3',
          title: 'Future Nostalgia',
          imageUrl:
              'https://images.unsplash.com/photo-1504893524553-b855bce32c67?w=300&h=300&fit=crop',
          artist: 'Dua Lipa',
          trackCount: 11,
          isLiked: false,
        ),
        Album(
          id: 'a4',
          title: 'Radical Optimism',
          imageUrl:
              'https://images.unsplash.com/photo-1504893524553-b855bce32c67?w=300&h=300&fit=crop',
          artist: 'Dua Lipa',
          trackCount: 12,
          isLiked: false,
        ),
      ],
    ),
    Artist(
      id: '3',
      artistName: 'Imagine Dragons',
      imageUrl:
          'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=300&h=300&fit=crop',
      isLiked: false,

      albums: [
        Album(
          id: 'a5',
          title: 'Evolve',
          imageUrl:
              'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop',
          artist: 'Imagine Dragons',
          trackCount: 8,
          isLiked: true,
        ),
        Album(
          id: 'a6',
          title: 'Mercury',
          imageUrl:
              'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop',
          artist: 'Imagine Dragons',
          trackCount: 10,
          isLiked: true,
        ),
      ],
    ),
  ];

  @override
  Future<List<Artist>> getFeaturedArtists() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<List<Artist>> getFavoriteArtists() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData.where((e) => e.isLiked).toList();
  }

  @override
  Future<void> toggleLike(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
