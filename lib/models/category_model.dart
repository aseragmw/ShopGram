import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_shop/constants/firestore_constants.dart';

class Category {
  final String id;
  final String name;
  final String imgUrl;
  List<dynamic> productReferences;
  Category(this.id, this.productReferences, this.name, this.imgUrl);
  Category.fromFireStore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        productReferences =
            snapshot.data()[productReferencesColumn] as List<dynamic>,
        name = snapshot.data()[categoryNameColumn] as String,
        imgUrl = snapshot.data()[imgUrlColumn] as String;
}
