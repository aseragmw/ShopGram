import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../dialogs/create_dialogs/add_product_dialog.dart';

class CategoryScreenAppBar extends StatelessWidget {
  final Category category;
  const CategoryScreenAppBar({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const  EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 14, 32, 199),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                'Category Name',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 32, 199),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          IconButton(
              onPressed: () async {
                await showAddProductDialog(context,category);
              },
              icon:const Icon(Icons.add)),
        ],
      ),
    );
  }
}
