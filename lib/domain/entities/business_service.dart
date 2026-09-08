import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_service.freezed.dart';

@freezed
class BusinessService with _$BusinessService {
  const factory BusinessService({
    required int id,
    required String documentId,
    required String name,
    String? teaser,
    @Default(false) bool top,
    String? phone,
    String? email,
    String? social,
    String? address,
    String? contact,
    String? iconUrl,
    @Default([]) List<Map<String, dynamic>> paragraphs,
  }) = _BusinessService;
}
