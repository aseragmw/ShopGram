import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductScreenAppBar extends StatelessWidget {
  final String title;
  const ProductScreenAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 14, 32, 199)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 14, 32, 199)),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                color: Color.fromARGB(255, 14, 32, 199),
              ),
            )
          ],
        ));
  }
}
