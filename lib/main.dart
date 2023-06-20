import 'package:db_shop/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:db_shop/blocs/shopgram_bloc/shop_gram_bloc.dart';
import 'package:db_shop/screens/cart_screen.dart';
import 'package:db_shop/screens/category_screen.dart';
import 'package:db_shop/screens/home_screen.dart';
import 'package:db_shop/screens/landing_screen.dart';
import 'package:db_shop/screens/product_screen.dart';
import 'package:db_shop/screens/registeration/login_screen.dart';
import 'package:db_shop/screens/registeration/sign_up_screen.dart';
import 'package:db_shop/services/firestore_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirestoreDatabase.fetchCartProductList('r8QIyB8zbXdp7cEtEe9MILa7pdL2');
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthenticationBloc()),
        BlocProvider(create: (context)=>ShopGramBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          'homeScreen': (context) => const HomeScreen(),
          'cartScreen': (context) => const CartScreen(),
          'productScreen': (context) => ProductScreen(),
          'categoryScreen': (context) => CategoryScreen(),
          'loginScreen': (context) => LoginScreen(),
          'signUpScreen': (context) => SignUpScreen(),
          'landingScreen': (context) => LandingScreen()
        },
      ),
    );
  }
}
