import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/cart.dart';


import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class CartController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Define the products list as an RxList
  RxList<CartItem> _carts = <CartItem>[].obs;

  // Getter method to access the products list
  List<CartItem> get carts => _carts.value;


  Future<void> addtocart(CartItem product) async {
    final cartDoc = await _firestore.collection('carts').add(product.toMap());
    final cartId = cartDoc.id;
    await cartDoc.update({'id': cartId});
    Get.snackbar(
      'Cart',
      'Successfully added to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }


  Future<void> updateProduct(CartItem cartitems) async {
    final docId = await _firestore
        .collection('carts')
        .where('buyerPhoneNumber', isEqualTo: cartitems.buyerPhoneNumber)
        .where('name', isEqualTo: cartitems.productname)
        .where('image', isEqualTo: cartitems.imageUrl)
        .get()
        .then((snapshot) => snapshot.docs.first.id);
    await _firestore.collection('carts').doc(docId).update(cartitems.toMap());
  }



    Future<void> deletecartItem(List<CartItem> cartItems) async {
    try {
      // Delete each cart item from the cart collection
      WriteBatch batch = _firestore.batch();

      for (CartItem cartItem in cartItems) {
        batch.delete(_firestore.collection('carts').doc(cartItem.id!));
      }

      await batch.commit();
      Get.snackbar('Success', 'Order is place');

    } catch (e) {
      print('Error deleting cart items: $e');
    }
  }

  Future<void> deletecartIte(CartItem cartItem) async {
    try {
      await _firestore.collection('carts').doc(cartItem.id!).delete();
      Get.snackbar('Success', 'Item deleted successfully');
    } catch (e) {
      print('Error deleting cart item: $e');
    }
  }

  Future<void> getCartsItems(String buyerPhoneNumber) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('carts')
        .where('buyerPhoneNumber', isEqualTo: buyerPhoneNumber)
        .get();
    final cartss = querySnapshot.docs.map((doc) {
      return CartItem.fromMap(doc.data());
    }).toList();
    print(cartss);
    _carts.assignAll(cartss);
  }
}





