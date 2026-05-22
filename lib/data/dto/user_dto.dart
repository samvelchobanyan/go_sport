import 'package:go_sport/domain/entities/user.dart';

class _AvatarDto {
  final String url;

  _AvatarDto({required this.url});

  factory _AvatarDto.fromJson(Map<String, dynamic> json) {
    return _AvatarDto(url: json['url'] as String);
  }
}

class UserDto {
  final int id;
  final String documentId;
  final String username;
  final String email;
  final String name;
  final String surname;
  final String provider;
  final String? phone;
  final _AvatarDto? avatar;

  UserDto({
    required this.id,
    required this.documentId,
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    required this.provider,
    this.phone,
    this.avatar,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      documentId: json['documentId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      provider: json['provider'] as String? ?? '',
      phone: json['phone'] as String?,
      avatar: json['avatar'] != null
          ? _AvatarDto.fromJson(json['avatar'] as Map<String, dynamic>)
          : null,
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
      provider: provider,
      avatar: avatar?.url,
    );
  }
}
