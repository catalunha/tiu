import 'package:tiu/app/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> registerEmail(
      {required String email, required String password});
  Future<UserModel?> loginEmail(
      {required String email, required String password});
  Future<bool> logout();
  Future<void> forgotPassword(String email);
}
