import 'package:db_shop/models/product_model.dart';
import 'package:flutter/material.dart';

import 'cards/cart_item_card.dart';

class CartItemsWidget extends StatelessWidget {
  final Map<Product, int> products;
  const CartItemsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        for (int i = 0; i < products.entries.length; i++)
          CartItemCard(
              product: products.entries.elementAt(i).key,
              amount: products.entries.elementAt(i).value)
      ],
    );
  }
}
