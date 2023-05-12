

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/product_model.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Define the products list as an RxList
  RxList<ProductModel> _products = <ProductModel>[].obs;

  // Getter method to access the products list
  List<ProductModel> get products => _products.value;

  Future<void> getProducts(String subcategory) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('product')
        .where('subcategory', isEqualTo: subcategory)
        .get();
    final products = querySnapshot.docs.map((doc) {
      return ProductModel.fromMap(doc.data());
    }).toList();
    _products.assignAll(products);
  }
}
