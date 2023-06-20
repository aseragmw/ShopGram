import 'package:db_shop/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter/material.dart';

import '../../../models/category_model.dart';
import '../../../services/firestore_database.dart';

Future<void> showModifyCatedoryDialog(
    BuildContext context, Category category) async {
  TextEditingController categoryName = TextEditingController();
  TextEditingController categoryImage = TextEditingController();
  categoryName.text = category.name;
  categoryImage.text = category.imgUrl;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text('Update Category'),
              TextField(
                controller: categoryName..text,
                decoration: const InputDecoration(hintText: 'name'),
              ),
              TextField(
                controller: categoryImage,
                decoration: const InputDecoration(hintText: 'image'),
              ),
              TextButton(
                  onPressed: () async {
                    final shouldModify = await showConfirmationDialog(
                        context, 'Update Category?');
                    if (shouldModify) {
                      if (categoryName.text.isNotEmpty &&
                          categoryName.text != category.name) {
                        await FirestoreDatabase.getInstance().updateCategory(
                            {'name': categoryName.text}, category);
                      } else if (categoryImage.text.isNotEmpty &&
                          categoryImage.text != category.imgUrl) {
                        await FirestoreDatabase.getInstance().updateCategory(
                            {'img_url': categoryImage.text}, category);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('update')),
              TextButton(
                  onPressed: () async {
                    final shouldDelete = await showConfirmationDialog(
                        context, 'Delete Categoroy?');
                    if (shouldDelete) {
                      await FirestoreDatabase.getInstance()
                          .deleteCategory(category);
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text('delete category')),
            ],
          ),
        ));
      });
}
