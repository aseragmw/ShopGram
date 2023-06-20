import 'package:db_shop/services/authentication/auth_exceptions.dart';
import 'package:db_shop/services/authentication/auth_provider.dart';
import 'package:db_shop/services/authentication/auth_user.dart';
import 'package:db_shop/services/authentication/firebase_auth_service.dart';
import 'package:db_shop/services/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthProvider extends ShopGramAuthProvider {
  @override
  Future<void> createAccount(
      String email, String password, String fullName) async {
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirestoreDatabase.getInstance().createNewCart(user.user!.uid);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(fullName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUse();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else if (e.code == 'weak-password') {
        throw WeakPassword();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get CurrentUser {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print('here');

      final usr = AuthUser.fromFirebase(user);
      print('user is ${usr.fullName}');
      return usr;
    } else {
      print('user is null');
      return null;
    }
  }

  @override
  Future<AuthUser> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return FirebaseAuthService.fromFirebase().CurrentUser!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw WrongCredintials();
      } else if (e.code == 'user-disabled') {
        throw UserBlocked();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> sendVerificationMail(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } else {
      throw UserNotLoggedIn();
    }
  }
}
