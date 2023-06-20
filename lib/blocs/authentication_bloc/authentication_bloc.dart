//import flutter packages get;
import 'package:db_shop/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import '../../services/authentication/auth_exceptions.dart';
import '../../services/authentication/auth_user.dart';
import '../../services/authentication/firebase_auth_service.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<CreateAccountEvent>((event, emit) async {
      try {
        await FirebaseAuthService.fromFirebase()
            .createAccount(event.email, event.password, event.fullName);

        await FirebaseAuthService.fromFirebase()
            .sendVerificationMail(event.email);
        Navigator.of(event.context)
            .pushNamedAndRemoveUntil('loginScreen', (route) => false);
      } on AuthException catch (e) {
        if (e.runtimeType == InvalidEmail) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Invalid Email'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        } else if (e.runtimeType == WeakPassword) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Weak Passsword'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        } else if (e.runtimeType == EmailAlreadyInUse) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Email is already in use'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Something Went Wrong..'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          content: Text('Something Went Wrong..'),
          backgroundColor: Color.fromARGB(255, 14, 32, 199),
        ));
      }
    });

    on<LoginEvent>((event, emit) async {
      try {
        await FirebaseAuthService.fromFirebase()
            .login(event.email, event.password);

        final AuthUser? user = FirebaseAuthService.fromFirebase().CurrentUser;

        if (user!.isVerified) {
          await FirestoreDatabase.fetchCartProductList(user.id);
          Navigator.of(event.context)
              .pushNamedAndRemoveUntil('landingScreen', (route) => false);
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 6),
            content: Text(
                'We sent you verification mail, check it and login again..'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        }
      } on AuthException catch (e) {
        if (e.runtimeType == InvalidEmail) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Invalid Email'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        } else if (e.runtimeType == WrongCredintials) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Wrong Credintials'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        } else if (e.runtimeType == UserBlocked) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('User Blocked'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        } else if (e.runtimeType == UserNotLoggedIn) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Errorrrr'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Something Went Wrong..'),
            backgroundColor: Color.fromARGB(255, 14, 32, 199),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          content: Text('Something Went Wrong.....'),
          backgroundColor: Color.fromARGB(255, 14, 32, 199),
        ));
      }
    });
  }
}
