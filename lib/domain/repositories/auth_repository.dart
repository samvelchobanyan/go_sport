import 'package:go_sport/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<({String jwt, User user})> login({
    required String identifier,
    required String password,
  });
}
