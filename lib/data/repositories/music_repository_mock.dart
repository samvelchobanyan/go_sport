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
      artistName: 'The Weeknd',
      albums: [
        Album(
          id: 'a1',
          title: 'After Hours',
          artist: 'The Weeknd',
          imageUrl:
              'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
          trackCount: 14,
          isLiked: true,
        ),
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      isLiked: true,
    ),
    Artist(
      id: '2',
      artistName: 'Dua Lipa',
      albums: [
        Album(
          id: 'a3',
          title: 'Future Nostalgia',
          artist: 'Dua Lipa',
          imageUrl:
              'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
          trackCount: 11,
          isLiked: false,
        ),
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      isLiked: false,
    ),
    Artist(
      id: '3',
      artistName: 'Billie Eilish',
      albums: [
        Album(
          id: 'a5',
          title: 'Happier Than Ever',
          artist: 'Billie Eilish',
          imageUrl:
              'https://images.unsplash.com/photo-1511379938547-c1f69b13d835?auto=format&fit=crop&w=800&q=80',
          trackCount: 12,
          isLiked: true,
        ),
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1511379938547-c1f69b13d835?auto=format&fit=crop&w=800&q=80',
      isLiked: true,
    ),
    Artist(
      id: '4',
      artistName: 'Post Malone',
      albums: [
        Album(
          id: 'a6',
          title: 'Hollywood\'s Bleeding',
          artist: 'Post Malone',
          imageUrl:
              'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
          trackCount: 10,
          isLiked: false,
        ),
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      isLiked: false,
    ),
    Artist(
      id: '5',
      artistName: 'Ariana Grande',
      albums: [
        Album(
          id: 'a7',
          title: 'Positions',
          artist: 'Ariana Grande',
          imageUrl:
              'https://images.unsplash.com/photo-1506157786151-b8491531f063?auto=format&fit=crop&w=800&q=80',
          trackCount: 12,
          isLiked: true,
        ),
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?auto=format&fit=crop&w=800&q=80',
      isLiked: true,
    ),
    Artist(
      id: '6',
      artistName: 'Taylor Swift',
      albums: [
        Album(
          id: 'a8',
          title: 'Midnights',
          artist: 'Taylor Swift',
          imageUrl:
              'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
          trackCount: 13,
          isLiked: false,
        ),
      ],
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
