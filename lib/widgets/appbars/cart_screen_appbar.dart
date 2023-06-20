import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CartScreenAppBar extends StatelessWidget {
  const CartScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Cart',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 14, 32, 199)),
                ),
              ),
            ),
          ],
        ));
  }
}
