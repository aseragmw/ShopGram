import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_shop/services/authentication/firebase_auth_service.dart';
import 'package:db_shop/services/firestore_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/product_model.dart';
import '../widgets/appbars/product_screen_appbar.dart';

class ProductScreen extends StatelessWidget {
  int amount = 0;
  List<Color> clrs = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.brown
  ];

  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final product = args['product'] as Product;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 238, 238),
      body: ListView(
        shrinkWrap: true,
        children: [
          ProductScreenAppBar(title: product.title),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 300,
              width: 300,
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(300),
                  child: Image.network(
                    product.imgUrl,
                  ),
                ),
              ),
            ),
          ),
          Arc(
            edge: Edge.TOP,
            height: 30,
            arcType: ArcType.CONVEY,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                margin: EdgeInsets.all(6),
                                child: Text(
                                  product.title,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 14, 32, 199),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(6),
                                child: RatingBar.builder(
                                    allowHalfRating: true,
                                    initialRating: product.rating,
                                    itemBuilder: (context, _) {
                                      return Icon(
                                        Icons.favorite,
                                        color: Color.fromARGB(255, 14, 32, 199),
                                      );
                                    },
                                    itemSize: 20,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    onRatingUpdate: (index) {}),
                              )
                            ],
                          ),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        amount += 1;
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 1,
                                                  spreadRadius: 3)
                                            ]),
                                        child: Icon(
                                          CupertinoIcons.plus,
                                          color:
                                              Color.fromARGB(255, 14, 32, 199),
                                        )),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(amount.toString()),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (amount - 1 >= 0) {
                                        setState(() {
                                          amount -= 1;
                                        });
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 1,
                                                  spreadRadius: 3)
                                            ]),
                                        child: Icon(
                                          CupertinoIcons.minus,
                                          color:
                                              Color.fromARGB(255, 14, 32, 199),
                                        )),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        product.description,
                        style:
                            TextStyle(color: Color.fromARGB(255, 14, 32, 199)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            'Size :',
                            style: TextStyle(
                                color: Color.fromARGB(255, 14, 32, 199),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          for (int i = 0; i < 5; i++)
                            Container(
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 1,
                                        spreadRadius: 3)
                                  ]),
                              child: Text(
                                '$i',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 14, 32, 199),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            'Colors :',
                            style: TextStyle(
                                color: Color.fromARGB(255, 14, 32, 199),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          for (int i = 0; i < 5; i++)
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: clrs[i],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 1,
                                        spreadRadius: 3)
                                  ]),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                product.price.toString(),
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 32, 199),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (amount > 0) {
                    print(FirebaseAuthService.fromFirebase().CurrentUser!.id);
                    FirestoreDatabase.getInstance().addProductToCart(
                        product,
                        amount,
                        FirebaseAuthService.fromFirebase().CurrentUser!.id);
                  }
                },
                icon: Icon(Icons.shopping_cart),
                label: Text(
                  'Add To Cart',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 15)),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 14, 32, 199)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
