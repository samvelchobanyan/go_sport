import 'dart:io';

import 'package:go_sport/domain/entities/user.dart';

abstract interface class ProfileRepository {
  Future<User> getUser();

  Future<void> deleteUser({required String password});

  Future<void> deleteUserWithGoogle({required String accessToken});

  Future<void> updateUser({String? name, String? surname, File? avatar});

  Future<void> deleteAvatar();

  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  });
}
