import 'package:go_sport/domain/entities/user.dart';

abstract interface class ProfileRepository {
  Future<User> getUser();

  Future<void> deleteUser();

  Future<User> updateUser({String? name, String? surname, String? avatar});

  Future<void> deleteAvatar();

  Future<User> changePassword();
}
