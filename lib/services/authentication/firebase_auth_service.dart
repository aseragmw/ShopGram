import 'package:db_shop/services/authentication/auth_provider.dart';
import 'package:db_shop/services/authentication/auth_user.dart';
import 'package:db_shop/services/authentication/firebase_auth_provider.dart';

class FirebaseAuthService extends ShopGramAuthProvider {
  final ShopGramAuthProvider provider;

  FirebaseAuthService(this.provider);
  factory FirebaseAuthService.fromFirebase()=> FirebaseAuthService(FirebaseAuthProvider());

  @override
  Future<void> createAccount(String email, String password,String fullName) {
    return provider.createAccount(email, password,fullName);
  }

  @override
  AuthUser? get CurrentUser {
    return provider.CurrentUser;
  }

  @override
  Future<AuthUser> login(String email, String password) {
    return provider.login(email, password);
  }

  @override
  Future<void> sendVerificationMail(String email) {
    return provider.sendVerificationMail(email);
  }
}
