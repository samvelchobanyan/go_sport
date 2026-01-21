import '../../domain/repositories/artist_repository.dart';
import '../../domain/entities/artist.dart';

class ArtistRepositoryMock implements ArtistRepository {
  final List<Artist> _mockData = [
    Artist(
      id: '1',
      title: 'The Weeknd',
      albumName: 'After Hours',
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      liked: true,
    ),
    Artist(
      id: '2',
      title: 'Dua Lipa',
      albumName: 'Future Nostalgia',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
      liked: false,
    ),
    Artist(
      id: '3',
      title: 'Billie Eilish',
      albumName: 'Happier Than Ever',
      imageUrl:
          'https://images.unsplash.com/photo-1511379938547-c1f69b13d835?auto=format&fit=crop&w=800&q=80',
      liked: true,
    ),
    Artist(
      id: '4',
      title: 'Post Malone',
      albumName: 'Hollywood\'s Bleeding',
      imageUrl:
          'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      liked: false,
    ),
    Artist(
      id: '5',
      title: 'Ariana Grande',
      albumName: 'Positions',
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?auto=format&fit=crop&w=800&q=80',
      liked: true,
    ),
    Artist(
      id: '6',
      title: 'Taylor Swift',
      albumName: 'Midnights',
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      liked: false,
    ),
  ];

  @override
  Future<List<Artist>> getFeaturedArtists() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }
}
