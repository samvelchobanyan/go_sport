import 'package:go_sport/domain/entities/user.dart';

class UserDto {
  final int id;
  final String documentId;
  final String username;
  final String email;
  final String name;
  final String surname;
  final String? phone;

  UserDto({
    required this.id,
    required this.documentId,
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    this.phone,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      documentId: json['documentId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      phone: json['phone'] as String?,
    );
  }

  User toDomain() {
    return User(
      id: id,
      documentId: documentId,
      username: username,
      email: email,
      name: name,
      surname: surname,
      phone: phone,
    );
  }
}
