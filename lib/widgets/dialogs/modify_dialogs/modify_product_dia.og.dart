import 'package:db_shop/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter/material.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../../services/firestore_database.dart';

Future<void> showModifyProductDialog(
    BuildContext context, Product product, Category? category) async {
  TextEditingController itemTitle = TextEditingController();
  TextEditingController itemDescription = TextEditingController();
  TextEditingController itemSale = TextEditingController();
  TextEditingController itemPrice = TextEditingController();
  TextEditingController itemStock = TextEditingController();
  TextEditingController itemImage = TextEditingController();
  TextEditingController itemRating = TextEditingController();
  itemTitle.text = product.title;
  itemDescription.text = product.description;
  itemSale.text = product.sale.toString();
  itemPrice.text = product.price.toString();
  itemStock.text = product.stock.toString();
  itemImage.text = product.imgUrl;
  itemRating.text = product.rating.toString();

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('Update Product'),
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
                      final shouldModiy = await showConfirmationDialog(
                          context, 'update product?');
                      if (shouldModiy) {
                        if (itemTitle.text.isNotEmpty &&
                            itemTitle.text != product.title) {
                          await FirestoreDatabase.getInstance().updateProdcut(
                              {'title': itemTitle.text}, product);
                        } else if (itemDescription.text.isNotEmpty &&
                            itemDescription.text != product.description) {
                          await FirestoreDatabase.getInstance().updateProdcut(
                              {'description': itemDescription.text}, product);
                        } else if (itemSale.text.isNotEmpty &&
                            itemSale.text != product.sale.toString()) {
                          await FirestoreDatabase.getInstance()
                              .updateProdcut({'sale': itemSale.text}, product);
                        } else if (itemStock.text.isNotEmpty &&
                            itemStock.text != product.stock.toString()) {
                          await FirestoreDatabase.getInstance().updateProdcut(
                              {'stock': itemStock.text}, product);
                        } else if (itemPrice.text.isNotEmpty &&
                            itemPrice.text != product.price.toString()) {
                          await FirestoreDatabase.getInstance().updateProdcut(
                              {'price': itemPrice.text}, product);
                        } else if (itemImage.text.isNotEmpty &&
                            itemImage.text != product.imgUrl) {
                          await FirestoreDatabase.getInstance().updateProdcut(
                              {'img_url': itemImage.text}, product);
                        } else if (itemRating.text.isNotEmpty &&
                            itemRating.text != product.rating.toString()) {
                          await FirestoreDatabase.getInstance().updateProdcut(
                              {'rating': itemRating.text}, product);
                        }
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text('update product')),
                TextButton(
                    onPressed: () async {
                      final category = await FirestoreDatabase.getInstance()
                          .getCategory(product.categoryId);
                      await FirestoreDatabase.getInstance()
                          .deleteProduct(product, category);
                      Navigator.of(context).pop();
                    },
                    child: Text('delete product')),
              ],
            ),
          ),
        );
      });
}
