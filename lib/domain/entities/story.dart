class Story {
  final String id;
  final String title;
  final String imageUrl;
  final bool isViewed;

  const Story({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isViewed = false,
  });
}