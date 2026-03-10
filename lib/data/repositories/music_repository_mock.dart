import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/repositories/music_repository.dart';

class MusicRepositoryMock implements MusicRepository {
  @override
  Future<int> getFavoritesCount() async => 5;

  @override
  Future<int> getPlaylistsCount() async => 14;

  @override
  Future<int> getAlbumsCount() async => 21;

  @override
  Future<int> getArtistsCount() async => 16;

  @override
  Future<int> getEpisodesCount() async => 6;

  @override
  Future<int> getProgramsCount() async => 5;

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

  final List<Artist> _mockData = [
    Artist(
      id: '1',
      title: 'The Weeknd',
      albumName: 'After Hours',
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      isLiked: true,
    ),
    Artist(
      id: '2',
      title: 'Dua Lipa',
      albumName: 'Future Nostalgia',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
      isLiked: false,
    ),
    Artist(
      id: '3',
      title: 'Billie Eilish',
      albumName: 'Happier Than Ever',
      imageUrl:
          'https://images.unsplash.com/photo-1511379938547-c1f69b13d835?auto=format&fit=crop&w=800&q=80',
      isLiked: true,
    ),
    Artist(
      id: '4',
      title: 'Post Malone',
      albumName: 'Hollywood\'s Bleeding',
      imageUrl:
          'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      isLiked: false,
    ),
    Artist(
      id: '5',
      title: 'Ariana Grande',
      albumName: 'Positions',
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?auto=format&fit=crop&w=800&q=80',
      isLiked: true,
    ),
    Artist(
      id: '6',
      title: 'Taylor Swift',
      albumName: 'Midnights',
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      isLiked: false,
    ),
  ];

  @override
  Future<List<Artist>> getFeaturedArtists() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }

  @override
  Future<List<Album>> getAlbums() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _albums;
  }
}
