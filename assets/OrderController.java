
class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _orderCollection =
  FirebaseFirestore.instance.collection('orders');

  // Define the order list as an RxList
  RxList<Orders> _orders = <Orders>[].obs;

  // Getter method to access the products list
  List<Orders> get orders => _orders.value;