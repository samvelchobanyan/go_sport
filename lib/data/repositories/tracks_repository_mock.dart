import 'package:go_sport/domain/repositories/track_repository.dart';

import '../../domain/entities/track.dart';
import '../../domain/entities/artist.dart';

class TrackRepositoryMock implements TrackRepository {
  final List<Track> _mockData = [
    Track(
      id: '1',
      title: 'Blinding Lights',
      artists: [
        Artist(
          id: 'artist_1',
          artistName: 'The Weeknd',
          imageUrl:
              'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
        )
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 20),
      audioUrl: '',
    ),
    Track(
      id: '2',
      title: 'Levitating',
      artists: [
        Artist(
          id: 'artist_2',
          artistName: 'Dua Lipa',
          imageUrl:
              'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
        )
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 23),
      audioUrl: '',
    ),
    Track(
      id: '3',
      title: 'Therefore I Am',
      artists: [
        Artist(
          id: 'artist_3',
          artistName: 'Billie Eilish',
          imageUrl:
              'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
        )
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 58),
      audioUrl: '',
    ),
    Track(
      id: '4',
      title: 'Circles',
      artists: [
        Artist(
          id: 'artist_4',
          artistName: 'Post Malone',
          imageUrl:
              'https://images.unsplash.com/photo-1511379938547-c1f69b13d835?auto=format&fit=crop&w=800&q=80',
        )
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1511379938547-c1f69b13d835?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 34),
      audioUrl: '',
    ),
    Track(
      id: '5',
      title: 'thank u, next',
      artists: [
        Artist(
          id: 'artist_5',
          artistName: 'Ariana Grande',
          imageUrl:
              'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
        )
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 31),
      audioUrl: '',
    ),
    Track(
      id: '6',
      title: 'Anti-Hero',
      artists: [
        Artist(
          id: 'artist_6',
          artistName: 'Taylor Swift',
          imageUrl:
              'https://images.unsplash.com/photo-1506157786151-b8491531f063?auto=format&fit=crop&w=800&q=80',
        )
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 21),
      audioUrl: '',
    ),
  ];

  @override
  Future<List<Track>> getAllTracks() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }


}
