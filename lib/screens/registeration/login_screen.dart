import 'package:db_shop/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:db_shop/constants/firestore_constants.dart';
import 'package:db_shop/services/authentication/auth_exceptions.dart';
import 'package:db_shop/services/authentication/firebase_auth_provider.dart';
import 'package:db_shop/services/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/authentication/auth_user.dart';
import '../../services/authentication/firebase_auth_service.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  LoginScreen({super.key});

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
                      'Login',
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
                      const Icon(Icons.email_rounded),
                      const Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          controller: _email,
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
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          obscureText: true,
                          controller: _password,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 14, 32, 199),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_email.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please Enter Email'),
                            backgroundColor: Color.fromARGB(255, 14, 32, 199),
                          ));
                        } else if (_password.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please Enter password'),
                            backgroundColor: Color.fromARGB(255, 14, 32, 199),
                          ));
                        } else {
                          context.read<AuthenticationBloc>().add(LoginEvent(
                              _email.text.replaceAll(' ', ''),
                              _password.text.replaceAll(' ', ''),
                              context));
                        }
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
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'New To ShopGram?',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'signUpScreen', (route) => false);
                          },
                          child: const Text(
                            'Register',
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
