import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String documentId,
    required String username,
    required String email,
    required String name,
    required String surname,
     String? phone,
     String? avatar,
  }) = _User;
}
