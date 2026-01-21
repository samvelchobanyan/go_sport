import '../../domain/repositories/song_repository.dart';
import '../../domain/entities/song.dart';

class SongRepositoryMock implements SongRepository {
  final List<Song> _mockData = [
    Song(
      id: '1',
      title: 'Blinding Lights',
      artist: 'The Weeknd',
      albumName: 'After Hours',
      imageUrl:
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      liked: true,
      duration: const Duration(minutes: 3, seconds: 20),
    ),
    Song(
      id: '2',
      title: 'Levitating',
      artist: 'Dua Lipa',
      albumName: 'Future Nostalgia',
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      liked: false,
      duration: const Duration(minutes: 3, seconds: 23),
    ),
    Song(
      id: '3',
      title: 'Therefore I Am',
      artist: 'Billie Eilish',
      albumName: 'Happier Than Ever',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
      liked: true,
      duration: const Duration(minutes: 2, seconds: 58),
    ),
    Song(
      id: '4',
      title: 'Circles',
      artist: 'Post Malone',
      albumName: 'Hollywood\'s Bleeding',
      imageUrl:
          'https://images.unsplash.com/photo-1511379938547-c1f69b13d835?auto=format&fit=crop&w=800&q=80',
      liked: false,
      duration: const Duration(minutes: 3, seconds: 34),
    ),
    Song(
      id: '5',
      title: 'thank u, next',
      artist: 'Ariana Grande',
      albumName: 'thank u, next',
      imageUrl:
          'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      liked: true,
      duration: const Duration(minutes: 3, seconds: 31),
    ),
    Song(
      id: '6',
      title: 'Anti-Hero',
      artist: 'Taylor Swift',
      albumName: 'Midnights',
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?auto=format&fit=crop&w=800&q=80',
      liked: false,
      duration: const Duration(minutes: 3, seconds: 21),
    ),
  ];

  @override
  Future<List<Song>> getFeaturedSongs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }
}
