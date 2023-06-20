import 'package:db_shop/blocs/shopgram_bloc/shop_gram_bloc.dart';
import 'package:db_shop/models/product_model.dart';
import 'package:db_shop/services/authentication/firebase_auth_service.dart';
import 'package:db_shop/services/firestore_database.dart';
import 'package:db_shop/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final int amount;
  const CartItemCard({
    super.key,
    required this.product,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            child: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(300),
                child: Image.network(
                  product.imgUrl,
                ),
              ),
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 14, 32, 199),
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Text(
                  product.price.toString(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 14, 32, 199),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    final shouldDelete = await showConfirmationDialog(
                        context, 'Delete Product From Cart?');
                    if (shouldDelete) {
                      context.read<ShopGramBloc>().add(DeleteCartProductEvent(
                          FirebaseAuthService.fromFirebase().CurrentUser!.id,
                          product));
                    }
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
              Spacer(),
              StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<ShopGramBloc>().add(
                              IncrementCartProductCountEvent(
                                  FirebaseAuthService.fromFirebase()
                                      .CurrentUser!
                                      .id,
                                  product));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 1,
                                    spreadRadius: 3)
                              ],
                            ),
                            child: Icon(CupertinoIcons.plus)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(amount.toString()),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<ShopGramBloc>().add(
                              DecrementCartProductCountEvent(
                                  FirebaseAuthService.fromFirebase()
                                      .CurrentUser!
                                      .id,
                                  product));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 1,
                                      spreadRadius: 3)
                                ]),
                            child: Icon(CupertinoIcons.minus)),
                      ),
                    ],
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
