import 'package:db_shop/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:db_shop/constants/firestore_constants.dart';
import 'package:db_shop/services/authentication/auth_exceptions.dart';
import 'package:db_shop/services/authentication/firebase_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/authentication/firebase_auth_service.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 14, 32, 199),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.person),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          controller: fullName,
                          decoration: const InputDecoration(
                            hintText: 'Full Name',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.email_rounded),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email Address',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          obscureText: true,
                          controller: password,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text(
                          'By signing in, you agree to our Terms & Conditions and Pricavy Police')),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        context.read<AuthenticationBloc>().add(
                            CreateAccountEvent(
                                email.text.replaceAll(' ', ''),
                                password.text.replaceAll(' ', ''),
                                fullName.text,
                                context));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 14, 32, 199),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Text('Sign Up'),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Joined us before?',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'loginScreen', (route) => false);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Color.fromARGB(255, 14, 32, 199),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
