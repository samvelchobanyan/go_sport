import '../../domain/repositories/story_repository.dart';
import '../../domain/entities/story.dart';

class StoryRepositoryMock implements StoryRepository {
  
  final List<Story> _mockStories = [
    const Story(
      id: 's1',
      title: 'Coldplay',
      imageUrl: 'https://images.unsplash.com/photo-1540039155733-5bb30b53aa14?auto=format&fit=crop&w=800&q=80',
      text: 'Check out our new single "Good Feelings" available now everywhere!',
      isViewed: false,
      ctaLabel: 'Listen now',
      ctaTargetType: 'track',
      ctaTargetId: 'track_coldplay_1',
    ),
    const Story(
      id: 's2',
      title: 'Radio Go Sport',
      imageUrl: 'https://images.unsplash.com/photo-1478737270239-2f02b77fc618?auto=format&fit=crop&w=800&q=80',
      text: 'Live interview with the champions starts in 10 minutes.',
      isViewed: true,
      ctaLabel: 'Tune in',
      ctaTargetType: 'radio',
      ctaTargetId: 'radio_main',
    ),
    const Story(
      id: 's3',
      title: 'Billie Eilish',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=800&q=80',
      text: 'Behind the scenes of the new music video.',
      isViewed: false,
      ctaLabel: 'Watch',
      ctaTargetType: 'album',
      ctaTargetId: 'album_billie_1',
    ),
    const Story(
      id: 's4',
      title: 'The Weeknd',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=800&q=80',
      text: 'New album "After Hours" out now! Stream on all platforms.',
      isViewed: false,
      ctaLabel: 'Listen',
      ctaTargetType: 'album',
      ctaTargetId: 'album_weeknd_1',
    ),
    const Story(
      id: 's5',
      title: 'Taylor Swift',
      imageUrl: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?auto=format&fit=crop&w=800&q=80',
      text: 'Exclusive: Behind the scenes of the Eras Tour.',
      isViewed: true,
      ctaLabel: 'Explore',
      ctaTargetType: 'artist',
      ctaTargetId: 'artist_taylor_1',
    ),
    const Story(
      id: 's6',
      title: 'Ed Sheeran',
      imageUrl: 'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?auto=format&fit=crop&w=800&q=80',
      text: 'Join me for an acoustic session live on Radio Go Sport.',
      isViewed: false,
      ctaLabel: 'Join live',
      ctaTargetType: 'radio',
      ctaTargetId: 'radio_main',
    ),
    const Story(
      id: 's7',
      title: 'Dua Lipa',
      imageUrl: 'https://images.unsplash.com/photo-1619983081563-430f63602796?auto=format&fit=crop&w=800&q=80',
      text: 'New single "Dance The Night" is out! Check it out.',
      isViewed: false,
      ctaLabel: 'Play now',
      ctaTargetType: 'track',
      ctaTargetId: 'track_dua_1',
    ),
    const Story(
      id: 's8',
      title: 'Drake',
      imageUrl: 'https://images.unsplash.com/photo-1598387993441-a364f854c3e1?auto=format&fit=crop&w=800&q=80',
      text: 'Surprise album drop tonight at midnight!',
      isViewed: true,
      ctaLabel: 'Pre-save',
      ctaTargetType: 'album',
      ctaTargetId: 'album_drake_1',
    ),
    const Story(
      id: 's9',
      title: 'Ariana Grande',
      imageUrl: 'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?auto=format&fit=crop&w=800&q=80',
      text: 'Live performance tonight! Don\'t miss it.',
      isViewed: false,
      ctaLabel: 'Get tickets',
      ctaTargetType: 'artist',
      ctaTargetId: 'artist_ariana_1',
    ),
    const Story(
      id: 's10',
      title: 'Bruno Mars',
      imageUrl: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?auto=format&fit=crop&w=800&q=80',
      text: 'New tour dates announced! Presale starts tomorrow.',
      isViewed: false,
      ctaLabel: 'View dates',
      ctaTargetType: 'artist',
      ctaTargetId: 'artist_bruno_1',
    ),
    const Story(
      id: 's11',
      title: 'Beyoncé',
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=800&q=80',
      text: 'Renaissance World Tour coming to your city!',
      isViewed: true,
      ctaLabel: 'Learn more',
      ctaTargetType: 'artist',
      ctaTargetId: 'artist_beyonce_1',
    ),
    const Story(
      id: 's12',
      title: 'Post Malone',
      imageUrl: 'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?auto=format&fit=crop&w=800&q=80',
      text: 'Exclusive interview about the new album.',
      isViewed: false,
      ctaLabel: 'Watch',
      ctaTargetType: 'artist',
      ctaTargetId: 'artist_post_1',
    ),
  ];

  @override
  Future<List<Story>> getStories() async {
    // Имитируем быструю загрузку
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockStories;
  }
}