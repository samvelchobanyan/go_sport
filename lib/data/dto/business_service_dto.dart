import 'package:go_sport/domain/entities/business_service.dart';

class BusinessServiceDto {
  final int id;
  final String documentId;
  final String name;
  final String? teaser;
  final bool top;
  final String? phone;
  final String? email;
  final String? social;
  final String? address;
  final String? contact;
  final String? iconUrl;
  final List<Map<String, dynamic>> paragraphs;

  const BusinessServiceDto({
    required this.id,
    required this.documentId,
    required this.name,
    this.teaser,
    required this.top,
    this.phone,
    this.email,
    this.social,
    this.address,
    this.contact,
    this.iconUrl,
    required this.paragraphs,
  });

  factory BusinessServiceDto.fromJson(Map<String, dynamic> json) {
    final icon = json['Icon'] as Map<String, dynamic>?;
    final paragraphItems = json['Paragraphs'] as List<dynamic>? ?? const [];

    return BusinessServiceDto(
      id: json['id'] as int? ?? 0,
      documentId: json['documentId'] as String? ?? '',
      name: json['Name'] as String? ?? '',
      teaser: json['Teaser'] as String?,
      top: json['Top'] as bool? ?? false,
      phone: json['Phone'] as String?,
      email: json['Email'] as String?,
      social: json['Social'] as String?,
      address: json['Address'] as String?,
      contact: json['Contact'] as String?,
      iconUrl: icon?['url'] as String?,
      paragraphs: paragraphItems.whereType<Map<String, dynamic>>().toList(),
    );
  }

  BusinessService toDomain() {
    return BusinessService(
      id: id,
      documentId: documentId,
      name: name,
      teaser: teaser,
      top: top,
      phone: phone,
      email: email,
      social: social,
      address: address,
      contact: contact,
      iconUrl:
          iconUrl ??
          '', // Safe fallback if iconUrl is required on BusinessService
      paragraphs: paragraphs,
    );
  }
}
