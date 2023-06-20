import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileScreenAppBar extends StatelessWidget {
  const ProfileScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Profile',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 32, 199),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ))
        ],
      ),
    );
  }
}
