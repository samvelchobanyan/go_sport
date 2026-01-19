import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';

@freezed
class Story with _$Story {
  const factory Story({
    required String id,
    required String title,
    required String text,
    required String imageUrl,
    @Default(false) bool isViewed,
    required String ctaLabel,
    required String ctaTargetType,
    required String ctaTargetId,
  }) = _Story;
}