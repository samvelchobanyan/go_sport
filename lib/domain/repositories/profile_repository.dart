import 'dart:io';

import 'package:go_sport/domain/entities/user.dart';

abstract interface class ProfileRepository {
  Future<User> getUser();

  Future<void> deleteUser();

  Future<void> updateUser({String? name, String? surname, File? avatar});

  Future<void> deleteAvatar();

  Future<User> changePassword();
}
