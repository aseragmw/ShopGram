import 'package:db_shop/models/category_model.dart';
import 'package:db_shop/widgets/dialogs/modify_dialogs/modify_product_dia.og.dart';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 14, 32, 199),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    product.sale.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const Spacer(),
                const InkWell(
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onLongPress: () async {

              await showModifyProductDialog(context, product, null);
            },
            onTap: () {
              Navigator.of(context)
                  .pushNamed('productScreen', arguments: {'product': product});
            },
            child: Container(
              height: 100,
              width: 100,
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(100),
                  child: Image.network(
                    product.imgUrl,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              product.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 14, 32, 199)),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              product.description,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 13, color: Color.fromARGB(255, 14, 32, 199)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                Text(
                  product.price.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 14, 32, 199),
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Color.fromARGB(255, 14, 32, 199),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
