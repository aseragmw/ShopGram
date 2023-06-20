import 'package:db_shop/services/firestore_database.dart';
import 'package:db_shop/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreDatabase.getInstance().allBestSelling,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                return GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < snapshot.data!.length; i++)
                      ProductCard(product: snapshot.data!.elementAt(i),)
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
        });
  }
}
