import 'package:db_shop/services/firestore_database.dart';
import 'package:db_shop/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../widgets/appbars/category_screen_appbar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final category = args['category'] as Category;
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      children: [
        CategoryScreenAppBar(category: category),
        Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: StreamBuilder(
                stream: FirestoreDatabase.getInstance()
                    .getProductsForCategory(category),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:

                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        return GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: 0.68,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          children: [
                            for (int i = 0; i < snapshot.data!.length; i++)
                              ProductCard(product: snapshot.data!.elementAt(i))
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator(
                          color: Color.fromARGB(255, 14, 32, 199),
                        );
                      }
                    default:
                      return const CircularProgressIndicator(
                        color: Color.fromARGB(255, 14, 32, 199),
                      );
                  }
                })),
      ],
    ));
  }
}
