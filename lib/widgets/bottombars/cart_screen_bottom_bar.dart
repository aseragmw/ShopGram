import 'package:db_shop/services/firestore_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreenBottomAppBar extends StatelessWidget {
  const CartScreenBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 120,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Total :',
                  style: TextStyle(
                      color: Color.fromARGB(255, 14, 32, 199),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const Spacer(),
                StreamBuilder(
                    stream: FirestoreDatabase.cartTotalBillStreamController
                        .stream,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:

                        case ConnectionState.active:
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 14, 32, 199),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        default:
                          return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 14, 32, 199),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Check Out',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
