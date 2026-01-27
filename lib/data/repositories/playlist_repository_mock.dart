import '../../domain/repositories/playlist_repository.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/track.dart';

class PlaylistRepositoryMock implements PlaylistRepository {
  final List<Playlist> _featuredPlaylists = [
    const Playlist(
      id: 'pl1',
      title: 'The Best of Armenian Rock Top 30',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      trackCount: 30,
    ),
    const Playlist(
      id: 'pl2',
      title: 'Top Rock Bands in the World',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      trackCount: 30,
    ),
    const Playlist(
      id: 'pl3',
      title: 'The Best Pop Hits 2026',
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      trackCount: 25,
    ),
    const Playlist(
      id: 'pl4',
      title: 'Workout & Energy',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      trackCount: 42,
    ),
    const Playlist(
      id: 'pl5',
      title: 'Chill Vibes & Relax',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      trackCount: 18,
    ),
    const Playlist(
      id: 'pl6',
      title: 'Classic Rock Legends',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      trackCount: 50,
    ),
    const Playlist(
      id: 'pl7',
      title: 'Electronic Dreams',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      trackCount: 35,
    ),
  ];

  final List<Track> _mockTracks = [
    Track(
      id: 't1',
      title: 'Sky Full of Stars',
      artistName: 'Coldplay',
      imageUrl: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 23),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 't2',
      title: 'Look What You Made Me Do',
      artistName: 'Taylor Swift',
      imageUrl: 'https://images.unsplash.com/photo-1619983081563-430f63602796?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 31),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Track(
      id: 't3',
      title: 'Sky Full of Stars',
      artistName: 'Lady Gaga',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 52),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Track(
      id: 't4',
      title: 'Bohemian Rhapsody',
      artistName: 'Queen',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 5, seconds: 55),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Track(
      id: 't5',
      title: 'Up in The Air',
      artistName: 'Thirty Seconds to Mars',
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 35),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Track(
      id: 't6',
      title: 'Dark Horse',
      artistName: 'Katy Perry',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 35),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
    Track(
      id: 't7',
      title: 'Higher Power',
      artistName: 'Coldplay',
      imageUrl: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 52),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
    ),
    Track(
      id: 't8',
      title: 'Bad Liar',
      artistName: 'Imagine Dragons',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 21),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
    ),
    Track(
      id: 't9',
      title: 'Blinding Lights',
      artistName: 'The Weeknd',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 20),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
    ),
    Track(
      id: 't10',
      title: 'Levitating',
      artistName: 'Dua Lipa',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 23),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
    ),
    Track(
      id: 't11',
      title: 'Stay',
      artistName: 'The Kid LAROI & Justin Bieber',
      imageUrl: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 21),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
    ),
    Track(
      id: 't12',
      title: 'Shivers',
      artistName: 'Ed Sheeran',
      imageUrl: 'https://images.unsplash.com/photo-1619983081563-430f63602796?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 27),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
    ),
    Track(
      id: 't13',
      title: 'Heat Waves',
      artistName: 'Glass Animals',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 58),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
    ),
    Track(
      id: 't14',
      title: 'Easy On Me',
      artistName: 'Adele',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 44),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
    ),
    Track(
      id: 't15',
      title: 'Ghost',
      artistName: 'Justin Bieber',
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 33),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-15.mp3',
    ),
    Track(
      id: 't16',
      title: 'Peaches',
      artistName: 'Justin Bieber ft. Daniel Caesar',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 18),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-16.mp3',
    ),
    Track(
      id: 't17',
      title: 'Montero',
      artistName: 'Lil Nas X',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 17),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 't18',
      title: 'Save Your Tears',
      artistName: 'The Weeknd',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 35),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
  ];

  @override
  Future<List<Playlist>> getFeaturedPlaylists() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _featuredPlaylists;
  }

  @override
  Future<List<Track>> getPlaylistTracks(String playlistId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Возвращаем одинаковые треки для всех плейлистов (mock)
    return _mockTracks;
  }

  @override
  Future<void> toggleLike(String playlistId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _featuredPlaylists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final playlist = _featuredPlaylists[index];
      _featuredPlaylists[index] = playlist.copyWith(isLiked: !playlist.isLiked);
    }
  }
}
