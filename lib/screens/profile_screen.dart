import 'package:db_shop/services/authentication/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/appbars/profile_screen_appbar.dart';

class ProfileScreen extends StatelessWidget {
  List<Icon> icons = [
    Icon(
      Icons.person,
      color: Color.fromARGB(255, 14, 32, 199),
    ),
    Icon(Icons.gps_fixed, color: Color.fromARGB(255, 14, 32, 199)),
    Icon(Icons.phone, color: Color.fromARGB(255, 14, 32, 199))
  ];

  List<String> title = ['Personal Info', 'Address', 'Contact Us'];

  ProfileScreen({super.key});

  final currentUser = FirebaseAuthService.fromFirebase().CurrentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ProfileScreenAppBar(),
          Container(
            height: 700,
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          padding: EdgeInsets.all(10),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(120),
                              child: Image.asset(
                                'images/ahmed.jpg',
                                height: 200,
                                width: 200,
                              ),
                            ),
                          )),
                      Text(
                        currentUser!.fullName!,
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 14, 32, 199),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currentUser!.email,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 14, 32, 199),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 14, 32, 199)),
                            padding: EdgeInsets.all(15),
                            child: Center(
                              child: InkWell(
                                child: Icon(
                                  Icons.list,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Orders',
                            style: TextStyle(
                                color: Color.fromARGB(255, 14, 32, 199),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 14, 32, 199)),
                            padding: EdgeInsets.all(15),
                            child: Center(
                              child: InkWell(
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Wishlist',
                            style: TextStyle(
                                color: Color.fromARGB(255, 14, 32, 199),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < 3; i++)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        icons[i],
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          title[i],
                          style: TextStyle(
                              color: Color.fromARGB(255, 14, 32, 199),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(
                          flex: 10,
                        ),
                        Icon(
                          Icons.arrow_circle_right,
                          color: Color.fromARGB(255, 14, 32, 199),
                        )
                      ],
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
