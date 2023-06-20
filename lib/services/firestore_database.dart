import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_shop/models/product_model.dart';
import 'package:db_shop/services/authentication/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';

class FirestoreDatabase {
  //Singleton
  factory FirestoreDatabase.getInstance() => _shared;

  static FirestoreDatabase _shared = FirestoreDatabase._sharedInstance();
  FirestoreDatabase._sharedInstance() {
    cartTotalBillStreamController = StreamController<double>.broadcast(
      onListen: () {
        cartTotalBillStreamController.sink.add(cartTotalBill);
      },
    );
  }

  Future<Iterable<Category>> categoriesList() async {
    return await allCategories.first;
  }

  Future<Iterable<Product>> productsList() async {
    return await allProducts.first;
  }

  //CRUD for categories
  Stream<Iterable<Category>> get allCategories => FirebaseFirestore.instance
      .collection('category')
      .snapshots()
      .map((event) => event.docs.map((e) => Category.fromFireStore(e)));

  Future<void> addCategory(Map<String, dynamic> obj) async {
    await FirebaseFirestore.instance.collection('category').add(obj);
  }

  Future<Category> getCategory(String categoryId) async {
    return await categoriesList().then(
        (value) => value.firstWhere((element) => element.id == categoryId));
  }

  Stream<Iterable<Product>> getProductsForCategory(Category category) =>
      FirebaseFirestore.instance
          .collection('items')
          .where('category_id', isEqualTo: category.id)
          .snapshots()
          .map((event) => event.docs.map((e) => Product.fromFirestore(e)));

  Future<void> updateCategory(
      Map<String, dynamic> obj, Category category) async {
    await FirebaseFirestore.instance
        .collection('category')
        .doc(category.id)
        .update(obj);
  }

  Future<void> deleteCategory(Category category) async {
    for (int i = 0; i < category.productReferences.length; i++) {
      await FirebaseFirestore.instance
          .collection('items')
          .doc(category.productReferences[i])
          .delete();
    }

    await FirebaseFirestore.instance
        .collection('category')
        .doc(category.id)
        .delete();
  }

//CRUD for product

  Future<Product> getProduct(String productId) async {
    return await productsList().then(
        (value) => value.firstWhere((element) => element.id == productId));
  }

  Stream<Iterable<Product>> get allProducts => FirebaseFirestore.instance
      .collection('items')
      .snapshots()
      .map((event) => event.docs.map((e) => Product.fromFirestore(e)));

  Future<String> addProduct(Map<String, dynamic> obj) async {
    final result =
        await FirebaseFirestore.instance.collection('items').add(obj);
    result.update({'id': result.id});
    return result.id;
  }

  Future<void> updateProdcut(Map<String, dynamic> obj, Product product) async {
    await FirebaseFirestore.instance
        .collection('items')
        .doc(product.id)
        .update(obj);
  }

  Future<void> deleteProduct(Product product, Category category) async {
    final categoryItemsList = category.productReferences;
    categoryItemsList.remove(product.id);
    await updateCategory({'product_refernces': categoryItemsList}, category);
    await FirebaseFirestore.instance
        .collection('items')
        .doc(product.id)
        .delete();
    await fetchCartProductList(
        FirebaseAuthService.fromFirebase().CurrentUser!.id);
  }

  //CRUD for Cart

  Future<void> createNewCart(String userId) async {
    final cart = await FirebaseFirestore.instance
        .collection('carts')
        .doc(userId)
        .set({'product_refernces': {}, 'id': userId});
  }

  // Stream<Iterable<Cart>> allCarts() {
  //   return FirebaseFirestore.instance
  //       .collection('carts')
  //       .snapshots()
  //       .map((event) => event.docs.map((e) => Cart.fromFireStore(e)));
  // }

  static Map<Product, int> cartProductsList = {};
  static late StreamController<Map<Product, int>> cartProductsStreamController =
      cartProductsStreamController =
          StreamController<Map<Product, int>>.broadcast(
    onListen: () {
      cartProductsStreamController.sink.add(cartProductsList);
    },
  );

  Future<void> addProductToCart(
      Product product, int amount, String cartId) async {
    final cartRef =
        await FirebaseFirestore.instance.collection('carts').doc(cartId).get();

    final productsList = cartRef.data() as Map<String, dynamic>;
    final list = productsList['product_refernces'] as Map<String, dynamic>;
    if (list[product.id] == null) {
      list[product.id] = amount;
      cartProductsList[product] = amount;
    } else if (list[product.id] > 0) {
      list[product.id] += amount;
      cartProductsList.entries.forEach((element) {
        if (element.key.id == product.id) {
          cartProductsList[element.key] =
              (cartProductsList[element.key]! + amount);
        }
      });
    }                         
    await FirebaseFirestore.instance
        .collection('carts')
        .doc(cartId)
        .update({'product_refernces': list});

    cartTotalBill += product.price * amount;
    cartTotalBillStreamController.add(cartTotalBill);
    cartProductsStreamController.add(cartProductsList);
  }

  Future<void> deleteProductFromCart(String cartId, Product product) async {
    final cartRef =
        await FirebaseFirestore.instance.collection('carts').doc(cartId).get();

    final productsList = cartRef.data()! as Map<String, dynamic>;
    final list = productsList['product_refernces'] as Map<String, dynamic>;

    list.remove(product.id);
    await FirebaseFirestore.instance
        .collection('carts')
        .doc(cartId)
        .update({'product_refernces': list});
    cartTotalBill -= cartProductsList[product]! * product.price;
    cartProductsList.remove(product);

    cartTotalBillStreamController.add(cartTotalBill);
    cartProductsStreamController.add(cartProductsList);
  }

  Future<void> incrementProductInCart(String cartId, Product product) async {
    final cartRef =
        await FirebaseFirestore.instance.collection('carts').doc(cartId).get();

    final productsList = cartRef.data()! as Map<String, dynamic>;
    final list = productsList['product_refernces'] as Map<String, dynamic>;

    list[product.id] += 1;
    cartProductsList.entries.forEach((element) {
      if (element.key.id == product.id) {
        cartProductsList[element.key] = (cartProductsList[element.key]! + 1);
      }
    });

    await FirebaseFirestore.instance
        .collection('carts')
        .doc(cartId)
        .update({'product_refernces': list});

    cartTotalBill += product.price;
    cartTotalBillStreamController.add(cartTotalBill);
    cartProductsStreamController.add(cartProductsList);
  }

  Future<void> decrementProductInCart(String cartId, Product product) async {
    final cartRef =
        await FirebaseFirestore.instance.collection('carts').doc(cartId).get();

    final productsList = cartRef.data()! as Map<String, dynamic>;
    final list = productsList['product_refernces'] as Map<String, dynamic>;
    list[product.id] -= 1;
    cartProductsList.entries.forEach((element) {
      if (element.key.id == product.id) {
        cartProductsList[element.key] = (cartProductsList[element.key]! - 1);
      }
    });

    await FirebaseFirestore.instance
        .collection('carts')
        .doc(cartId)
        .update({'product_refernces': list});

    // cartProductsList[product] = amount;
    cartTotalBill -= product.price;
    cartTotalBillStreamController.add(cartTotalBill);
    cartProductsStreamController.add(cartProductsList);
  }

  Stream<Map<Product, int>> getCartProductsStream() {
    return cartProductsStreamController.stream;
  }

  static Future<void> fetchCartProductList(String cartId) async {
    print('fetching');
    final cartRef =
        await FirebaseFirestore.instance.collection('carts').doc(cartId).get();
    print(cartRef.id);

    final cart = cartRef.data()! as Map<String, dynamic>;
    final list = cart['product_refernces'] as Map<String, dynamic>;
    for (int i = 0; i < list.length; i++) {
      print('iteration ${i}');
      final productRef = await FirebaseFirestore.instance
          .collection('items')
          .doc(list.keys.elementAt(i).toString().replaceAll(' ', ''))
          .get();
      if (productRef.data() == null) {
        print('before ${list}');
        for (int i = 0; i < cartProductsList.length; i++) {
          if (cartProductsList.keys.elementAt(i).id == list.keys.elementAt(i)) {
            cartProductsList.remove(cartProductsList.keys.elementAt(i));
          }
        }
        ;
        list.remove(list.keys.elementAt(i).toString());
        print('after${list}');
        await FirebaseFirestore.instance
            .collection('carts')
            .doc(cartId)
            .update({'product_refernces': list});
        cartProductsStreamController.add(cartProductsList);
       
        return;
      }
      final itemMap = productRef.data()! as Map<String, dynamic>;

      final product = Product(
          itemMap['category_id'] as String,
          itemMap['title'] as String,
          itemMap['description'] as String,
          double.parse(itemMap['price']),
          int.parse(itemMap['stock']),
          double.parse(itemMap['sale']),
          itemMap['colors'] as List<dynamic>,
          itemMap['sizes'] as List<dynamic>,
          double.parse(itemMap['rating']),
          itemMap['img_url'] as String,
          int.parse(itemMap['bought_count']),
          itemMap['id'].toString().replaceAll(' ', ''));

      print(product);

      cartProductsList[product] = list.values.elementAt(i);

      cartTotalBill += product.price * list.values.elementAt(i);
    }

    print('endd');
    print(cartProductsList.length);

    for (int i = 0; i < cartProductsList.length; i++) {
      print(cartProductsList.keys.elementAt(i).title);
      print(cartProductsList.values.elementAt(i));
    }
    cartProductsStreamController.add(cartProductsList);
  }

  static double cartTotalBill = 0;
  static late StreamController<double> cartTotalBillStreamController;

//Crud for bestselling
  Stream<Iterable<Product>> get allBestSelling => FirebaseFirestore.instance
      .collection('items')
      .snapshots()
      .map((event) => event.docs.map((e) => Product.fromFirestore(e)));
}
