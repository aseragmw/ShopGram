import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String id;
  final String email;
  final String? fullName;
  final bool isVerified;

  const AuthUser(
      {required this.fullName,
      required this.id,
      required this.email,
      required this.isVerified});
  factory AuthUser.fromFirebase(User user) => AuthUser(
      fullName: user.displayName,
      id: user.uid,
      email: user.email!,
      isVerified: user.emailVerified);
}
