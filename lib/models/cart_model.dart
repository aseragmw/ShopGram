import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_shop/constants/firestore_constants.dart';

class Cart {
  // the cart id is the same as the customer id
  final String id;
  List<String> productRefernces;

  Cart(this.id, this.productRefernces);
  Cart.fromFireStore(DocumentSnapshot< Map<String, dynamic>> snapshot)
      : id = snapshot.id as String,
      productRefernces = snapshot.data()![productReferencesColumn];
}
