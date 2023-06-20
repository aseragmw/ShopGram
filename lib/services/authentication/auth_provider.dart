import 'package:db_shop/services/authentication/auth_user.dart';

abstract class ShopGramAuthProvider {
  Future<AuthUser> login(String email, String password);
  Future<void> createAccount(String email, String password,String fullName);
  AuthUser? get CurrentUser;
  Future<void> sendVerificationMail(String email);
}
