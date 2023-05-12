import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'category mode.dart';




class CategoriController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _orderCollection =
  FirebaseFirestore.instance.collection('categor');  // Define the products list as an RxList


  RxList<Categories> _category = <Categories>[].obs;
  // Getter method to access the products list
  List<Categories> get categories => _category.value;


  // Getter method to access the products list


  Future<void> getCategories() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore.collection('categor').orderBy('range').get();
    final categories = querySnapshot.docs.map((doc) {
      return Categories.fromMap(doc.data());
    }).toList();
    _category.assignAll(categories);
  }

}
