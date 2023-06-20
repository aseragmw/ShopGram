import 'package:db_shop/services/authentication/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/shopgram_bloc/shop_gram_bloc.dart';
import '../services/firestore_database.dart';
import '../widgets/bottombars/cart_screen_bottom_bar.dart';
import '../widgets/cart_items_widget.dart';
import '../widgets/appbars/cart_screen_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    print('getting....');
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          const CartScreenAppBar(),
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height - 230,
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                 StreamBuilder(
                          stream: FirestoreDatabase.getInstance().getCartProductsStream(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                              case ConnectionState.active:
                                if (snapshot.hasData) {
                                  return CartItemsWidget(
                                      products: snapshot.data!);
                                } else {
                                  return CircularProgressIndicator(
                                    color: Colors.green,
                                  );
                                }

                              default:
                                return CircularProgressIndicator(
                                    color: Colors.yellow);
                            }
                          }),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.add_circled_solid,
                            color: Colors.deepPurple,
                          )),
                      const Text(
                        'Add Coupon Code',
                        style: TextStyle(
                            color: Color.fromARGB(255, 14, 32, 199),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CartScreenBottomAppBar(),
    );
  }
}
