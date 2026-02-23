import 'package:freezed_annotation/freezed_annotation.dart';

part 'program.freezed.dart';

@freezed
class Program with _$Program {
  const factory Program({
    required String id,
    required String title,
    String? imageUrl,
    String? description,
    required int episodeCount,
  }) = _Program;
}
