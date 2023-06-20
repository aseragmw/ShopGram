import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_shop/constants/firestore_constants.dart';

class Product {
  final String id;
  final String categoryId;
  String title;
  String description;
  double price;
  int stock;
  double sale;
  List<dynamic>? colors;
  List<dynamic>? sizes;
  double rating;
  String imgUrl;
  int boughtCount;

  Product(
      this.categoryId,
      this.title,
      this.description,
      this.price,
      this.stock,
      this.sale,
      this.colors,
      this.sizes,
      this.rating,
      this.imgUrl,
      this.boughtCount,
      this.id);

  Product.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        categoryId = snapshot.data()[categoryIdColumn],
        title = snapshot.data()[titleColummn] as String,
        description = snapshot.data()[descriptionColummn] as String,
        price = double.parse(snapshot.data()[priceColumn]),
        stock = int.parse(snapshot.data()[stockColumn]),
        sale = double.parse(snapshot.data()[saleColumn]),
        colors = snapshot.data()[colorsColumn] as List<dynamic>?,
        sizes = snapshot.data()[sizesColumn] as List<dynamic>?,
        rating = double.parse(snapshot.data()[ratingColumn]),
        imgUrl = snapshot.data()[imgUrlColumn] as String,
        boughtCount = int.parse(snapshot.data()[boughtCountColumn]);
       
}
