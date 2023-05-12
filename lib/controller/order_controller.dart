import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/order_model.dart';


class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _orderCollection =
  FirebaseFirestore.instance.collection('orders');

  // Define the order list as an RxList
  RxList<Orders> _orders = <Orders>[].obs;

  // Getter method to access the products list
  List<Orders> get orders => _orders.value;



  Future<void> addOrders(Orders orders) async {
    try {
      DocumentReference orderRef = await _orderCollection.add(orders.toMap());
      String orderId = orderRef.id;
      orders.id = orderId;
      await _orderCollection.doc(orderId).update({'id': orderId});
    } catch (e) {
      Get.snackbar('Error', 'Failed to save customer data.');
    }
  }
  Future<void> getorders(String buyerPhone) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('orders')
        .where('buyerPhone', isEqualTo: buyerPhone)
        .get();
    final ordr = querySnapshot.docs.map((doc) {
      return Orders.fromMap(doc.data());
    }).toList();
    _orders.assignAll(ordr);
  }

  Future<void> deleteOrder(Orders order) async {
    try {
      await _orderCollection.doc(order.id!).delete();
      Get.snackbar('Success', 'Order deleted');
    } catch (e) {
      print('Error deleting order: $e');
    }
  }
}