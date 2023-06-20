import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_shop/constants/firestore_constants.dart';

class Order {
  final String id;
  final List<String> productRefernces;
  final double total;
  final String customerNumber;
  bool deliviered;

  Order(this.id, this.productRefernces, this.total, this.customerNumber,
      this.deliviered);
  Order.fromFireStore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id as String,
        productRefernces =
            snapshot.data()[productReferencesColumn] as List<String>,
        total = snapshot.data()[totalColumn] as double,
        customerNumber = snapshot.data()[totalColumn] as String,
        deliviered = snapshot.data()[delieveredColumn] as bool;
}
