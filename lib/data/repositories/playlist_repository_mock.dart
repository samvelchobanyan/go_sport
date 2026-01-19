import '../../domain/repositories/playlist_repository.dart';
import '../../domain/entities/playlist.dart';

class PlaylistRepositoryMock implements PlaylistRepository {
  final List<Playlist> _featuredPlaylists = [
    const Playlist(
      id: 'pl1',
      title: 'The Best of Armenian Rock Top 30',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      trackCount: 30,
      trackIds: [],
    ),
    const Playlist(
      id: 'pl2',
      title: 'Top Rock Bands in the World',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      trackCount: 30,
      trackIds: [],
    ),
    const Playlist(
      id: 'pl3',
      title: 'The Best Pop Hits 2026',
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      trackCount: 25,
      trackIds: [],
    ),
    const Playlist(
      id: 'pl4',
      title: 'Workout & Energy',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      trackCount: 42,
      trackIds: [],
    ),
    const Playlist(
      id: 'pl5',
      title: 'Chill Vibes & Relax',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      trackCount: 18,
      trackIds: [],
    ),
    const Playlist(
      id: 'pl6',
      title: 'Classic Rock Legends',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      trackCount: 50,
      trackIds: [],
    ),
    const Playlist(
      id: 'pl7',
      title: 'Electronic Dreams',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      trackCount: 35,
      trackIds: [],
    ),
  ];

  @override
  Future<List<Playlist>> getFeaturedPlaylists() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _featuredPlaylists;
  }
}
