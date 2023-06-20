import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag,
                  color: Color.fromARGB(255, 14, 32, 199)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'DP Shop',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 14, 32, 199)),
              ),
            ),
          ],
        ));
  }
}
