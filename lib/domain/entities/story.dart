class Story {
  final String id;
  final String title;
  final String text;
  final String imageUrl;
  final bool isViewed;
  final String ctaLabel;
  final String ctaTargetType;
  final String ctaTargetId;

  const Story({
    required this.id,
    required this.title,
    required this.text,
    required this.imageUrl,
    this.isViewed = false,
    required this.ctaLabel,
    required this.ctaTargetType,
    required this.ctaTargetId,
  });
}