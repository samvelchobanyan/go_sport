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

  // Armenian Rock (pl1)
  final List<Track> _armenianRockTracks = [
    Track(
      id: 'arm1',
      title: 'Anytime You Need',
      artistName: 'Nemra',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 12),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 'arm2',
      title: 'Hayastan',
      artistName: 'System of a Down',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 45),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Track(
      id: 'arm3',
      title: 'Toxicity',
      artistName: 'System of a Down',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 39),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Track(
      id: 'arm4',
      title: 'Chop Suey!',
      artistName: 'System of a Down',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 30),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Track(
      id: 'arm5',
      title: 'Lonely Day',
      artistName: 'System of a Down',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 42),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Track(
      id: 'arm6',
      title: 'Rock Your Body',
      artistName: 'Dorians',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 18),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
  ];

  // World Rock (pl2)
  final List<Track> _worldRockTracks = [
    Track(
      id: 'wr1',
      title: 'Bohemian Rhapsody',
      artistName: 'Queen',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 5, seconds: 55),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 'wr2',
      title: 'Stairway to Heaven',
      artistName: 'Led Zeppelin',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 8, seconds: 2),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Track(
      id: 'wr3',
      title: 'Hotel California',
      artistName: 'Eagles',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 6, seconds: 30),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Track(
      id: 'wr4',
      title: 'Sweet Child O Mine',
      artistName: 'Guns N Roses',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 5, seconds: 56),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Track(
      id: 'wr5',
      title: 'Back in Black',
      artistName: 'AC/DC',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 15),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Track(
      id: 'wr6',
      title: 'Smells Like Teen Spirit',
      artistName: 'Nirvana',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 5, seconds: 1),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
  ];

  // Pop Hits (pl3)
  final List<Track> _popHitsTracks = [
    Track(
      id: 'pop1',
      title: 'Blinding Lights',
      artistName: 'The Weeknd',
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 20),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 'pop2',
      title: 'Levitating',
      artistName: 'Dua Lipa',
      imageUrl: 'https://images.unsplash.com/photo-1619983081563-430f63602796?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 23),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Track(
      id: 'pop3',
      title: 'Stay',
      artistName: 'The Kid LAROI & Justin Bieber',
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 21),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Track(
      id: 'pop4',
      title: 'Shivers',
      artistName: 'Ed Sheeran',
      imageUrl: 'https://images.unsplash.com/photo-1619983081563-430f63602796?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 27),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Track(
      id: 'pop5',
      title: 'Easy On Me',
      artistName: 'Adele',
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 44),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Track(
      id: 'pop6',
      title: 'As It Was',
      artistName: 'Harry Styles',
      imageUrl: 'https://images.unsplash.com/photo-1619983081563-430f63602796?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 47),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
  ];

  // Workout & Energy (pl4)
  final List<Track> _workoutTracks = [
    Track(
      id: 'wo1',
      title: 'Stronger',
      artistName: 'Kanye West',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 5, seconds: 12),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 'wo2',
      title: 'Lose Yourself',
      artistName: 'Eminem',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 5, seconds: 26),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Track(
      id: 'wo3',
      title: 'Eye of the Tiger',
      artistName: 'Survivor',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 5),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Track(
      id: 'wo4',
      title: 'Thunderstruck',
      artistName: 'AC/DC',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 52),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Track(
      id: 'wo5',
      title: 'Pump It',
      artistName: 'Black Eyed Peas',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 33),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Track(
      id: 'wo6',
      title: 'Believer',
      artistName: 'Imagine Dragons',
      imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 24),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
  ];

  // Chill Vibes (pl5)
  final List<Track> _chillTracks = [
    Track(
      id: 'ch1',
      title: 'Weightless',
      artistName: 'Marconi Union',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 8, seconds: 9),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 'ch2',
      title: 'Sunset Lover',
      artistName: 'Petit Biscuit',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 29),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Track(
      id: 'ch3',
      title: 'Intro',
      artistName: 'The xx',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 7),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Track(
      id: 'ch4',
      title: 'Electric Feel',
      artistName: 'MGMT',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 49),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Track(
      id: 'ch5',
      title: 'Breathe',
      artistName: 'Télépopmusik',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 38),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Track(
      id: 'ch6',
      title: 'Dreams',
      artistName: 'Fleetwood Mac',
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 14),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
  ];

  // Classic Rock (pl6)
  final List<Track> _classicRockTracks = [
    Track(
      id: 'cr1',
      title: 'We Will Rock You',
      artistName: 'Queen',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 2),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 'cr2',
      title: 'We Are the Champions',
      artistName: 'Queen',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 2, seconds: 59),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Track(
      id: 'cr3',
      title: 'Highway to Hell',
      artistName: 'AC/DC',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 28),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Track(
      id: 'cr4',
      title: 'Livin on a Prayer',
      artistName: 'Bon Jovi',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 9),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Track(
      id: 'cr5',
      title: 'November Rain',
      artistName: 'Guns N Roses',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 8, seconds: 57),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Track(
      id: 'cr6',
      title: 'Dream On',
      artistName: 'Aerosmith',
      imageUrl: 'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 28),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
  ];

  // Electronic Dreams (pl7)
  final List<Track> _electronicTracks = [
    Track(
      id: 'el1',
      title: 'Strobe',
      artistName: 'Deadmau5',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 10, seconds: 37),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Track(
      id: 'el2',
      title: 'Midnight City',
      artistName: 'M83',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 3),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Track(
      id: 'el3',
      title: 'Around the World',
      artistName: 'Daft Punk',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 7, seconds: 9),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Track(
      id: 'el4',
      title: 'Get Lucky',
      artistName: 'Daft Punk ft. Pharrell',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 6, seconds: 9),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Track(
      id: 'el5',
      title: 'Levels',
      artistName: 'Avicii',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 3, seconds: 19),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Track(
      id: 'el6',
      title: 'Titanium',
      artistName: 'David Guetta ft. Sia',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      duration: const Duration(minutes: 4, seconds: 5),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
  ];

  // Map плейлистов к трекам
  Map<String, List<Track>> get _playlistTracksMap => {
    'pl1': _armenianRockTracks,
    'pl2': _worldRockTracks,
    'pl3': _popHitsTracks,
    'pl4': _workoutTracks,
    'pl5': _chillTracks,
    'pl6': _classicRockTracks,
    'pl7': _electronicTracks,
  };

  @override
  Future<List<Playlist>> getFeaturedPlaylists() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _featuredPlaylists;
  }

  @override
  Future<List<Track>> getPlaylistTracks(String playlistId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Возвращаем треки в зависимости от playlistId
    return _playlistTracksMap[playlistId] ?? _popHitsTracks;
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
