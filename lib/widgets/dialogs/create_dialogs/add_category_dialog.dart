import 'package:flutter/material.dart';

import '../../../services/firestore_database.dart';

Future<void> showAddCategoryDialog(BuildContext context) async {
  TextEditingController categoryName = TextEditingController();
  TextEditingController categoryImage = TextEditingController();
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Container(
          width: double.maxFinite,
          child: ListView(
            children: [
              const Text('Add Category'),
              TextField(
                controller: categoryName,
                decoration: const InputDecoration(hintText: 'name'),
              ),
              TextField(
                controller: categoryImage,
                decoration: const InputDecoration(hintText: 'image'),
              ),
              TextButton(
                  onPressed: () async {
                    await FirestoreDatabase.getInstance().addCategory({
                      'name': categoryName.text,
                      'img_url': categoryImage.text,
                      'product_refernces': [],
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('add')),
            ],
          ),
        ));
      });
}
