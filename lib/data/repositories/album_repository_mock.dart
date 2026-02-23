import '../../domain/repositories/album_repository.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/track.dart';

class AlbumRepositoryMock implements AlbumRepository {
  final List<Album> _albums = [
    const Album(
      id: 'alb1',
      title: 'Rumours',
      artist: 'Fleetwood Mac',
      imageUrl:
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      trackCount: 12,
    ),
    const Album(
      id: 'alb2',
      title: 'The Dark Side of the Moon',
      artist: 'Pink Floyd',
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      trackCount: 10,
    ),
    const Album(
      id: 'alb3',
      title: 'Hotel California',
      artist: 'Eagles',
      imageUrl:
          'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      trackCount: 9,
    ),
    const Album(
      id: 'alb4',
      title: 'Abbey Road',
      artist: 'The Beatles',
      imageUrl:
          'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      trackCount: 17,
    ),
    const Album(
      id: 'alb5',
      title: 'Thriller',
      artist: 'Michael Jackson',
      imageUrl:
          'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      trackCount: 9,
    ),
    const Album(
      id: 'alb6',
      title: 'Born to Run',
      artist: 'Bruce Springsteen',
      imageUrl:
          'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      trackCount: 8,
    ),
  ];

  @override
  Future<List<Album>> getAlbums() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _albums;
  }

  @override
  Future<List<Track>> getAlbumTracks(String albumId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Return empty list for now
    return [];
  }

  @override
  Future<void> toggleLike(String albumId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Mock implementation
  }
}
