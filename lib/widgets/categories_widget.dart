import 'package:db_shop/services/firestore_database.dart';
import 'package:flutter/material.dart';

import 'cards/category_item_card.dart';
import 'dialogs/modify_dialogs/modify_category_dialog.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreDatabase.getInstance().allCategories,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < snapshot.data!.length; i++)
                        InkWell(
                          onLongPress: () async {
                            await showModifyCatedoryDialog(
                                context, snapshot.data!.elementAt(i));
                          },
                          onTap: () {
                            Navigator.of(context).pushNamed('categoryScreen',
                                arguments: {
                                  'category': snapshot.data!.elementAt(i)
                                });
                          },
                          child: CategoryItemCard(
                              category: snapshot.data!.elementAt(i)),
                        )
                    ],
                  ),
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
