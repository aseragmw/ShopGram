import 'package:flutter/material.dart';

import '../../../models/category_model.dart';
import '../../../services/firestore_database.dart';

Future<void> showAddProductDialog(
    BuildContext context, Category category) async {
  TextEditingController itemTitle = TextEditingController();
  TextEditingController itemDescription = TextEditingController();
  TextEditingController itemSale = TextEditingController();
  TextEditingController itemPrice = TextEditingController();
  TextEditingController itemStock = TextEditingController();
  TextEditingController itemImage = TextEditingController();
  TextEditingController itemRating = TextEditingController();

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('Add item'),
                TextField(
                  controller: itemTitle,
                  decoration: InputDecoration(hintText: 'title'),
                ),
                TextField(
                  controller: itemDescription,
                  decoration: InputDecoration(hintText: 'description'),
                ),
                TextField(
                  controller: itemImage,
                  decoration: InputDecoration(hintText: 'image'),
                ),
                TextField(
                  controller: itemStock,
                  decoration: InputDecoration(hintText: 'stock'),
                ),
                TextField(
                  controller: itemPrice,
                  decoration: InputDecoration(hintText: 'price'),
                ),
                TextField(
                  controller: itemSale,
                  decoration: InputDecoration(hintText: 'sale'),
                ),
                TextField(
                  controller: itemRating,
                  decoration: InputDecoration(hintText: 'rating'),
                ),
                TextButton(
                    onPressed: () async {
                      final productId =
                          await FirestoreDatabase.getInstance().addProduct({
                        'colors': [],
                        'description': itemDescription.text,
                        'category_id': category.id,
                        'img_url': itemImage.text,
                        'price': itemPrice.text,
                        'rating': itemRating.text,
                        'sale': itemSale.text,
                        'sizes': [],
                        'stock': itemStock.text,
                        'title': itemTitle.text,
                        'bought_count': '0',
                      });
                      final categoryListOfItems = category.productReferences;
                      categoryListOfItems.add(productId);
                      await FirestoreDatabase.getInstance().updateCategory(
                          {'product_refernces': categoryListOfItems}, category);
                      Navigator.of(context).pop();
                    },
                    child: Text('add')),
              ],
            ),
          ),
        );
      });
}
