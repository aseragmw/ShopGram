import 'package:db_shop/services/firestore_database.dart';
import 'package:db_shop/widgets/dialogs/modify_dialogs/modify_category_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class CategoryItemCard extends StatelessWidget {
  final Category category;

  const CategoryItemCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 5),
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(35),
                    child: Image.network(
                      category.imgUrl,
                    ),
                  ),
                ),
              )),
          Text(
            category.name,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 14, 32, 199)),
          ),
        ],
      ),
    );
  }
}
