import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../consts/consts.dart';
import '../models/customer_data.dart';
import '../models/retailer_models.dart';

class FirebaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  Future<void> saveRetailerData(RetailerModel retailer) async {
    try {
      final uid = _auth.currentUser!.uid;
      final retailerRef = _firestore.collection('retailers').doc(uid);
      await retailerRef.set(retailer.toMap());
      Get.snackbar('Success', 'Retailer data saved successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save retailer data.');
    }
  }

  Future<RetailerModel?> getRetailerData(String phoneNumber) async {
    try {
      final retailerRef = _firestore.collection('retailers').where('phoneNumber', isEqualTo: phoneNumber);
      final retailerSnapshot = await retailerRef.get();
      if (retailerSnapshot.docs.isNotEmpty) {
        final retailerData = RetailerModel.fromMap(retailerSnapshot.docs.first.data());
        return retailerData;
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get retailer data.');
      return null;
    }
  }

}

class CustomersService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _customersCollection =
  FirebaseFirestore.instance.collection('customers');




  // Define the customers list as an RxList
  RxList<Customer> _customers = <Customer>[].obs;

  // Getter method to access the customers list
  List<Customer> get customers => _customers.value;

  Future<void> addCustomer(Customer customer) async {
    try {
      await _customersCollection.add(customer.toMap());
      Get.snackbar('Success', 'Customer data saved successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save customer data.');
    }
  }

  Future<void> getCustomers(String phoneNumber) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('customers')
        .where('retailerPhoneNumber', isEqualTo: phoneNumber)
        .get();
    final cartss = querySnapshot.docs.map((doc) {
      return Customer.fromMap(doc.data());
    }).toList();
    print(cartss);
    _customers.assignAll(cartss);
  }
  RxList<Transactio> _transactions = RxList<Transactio>([]);
  bool _isLoading = false;

  // Define the customers list as an RxList
  List<Transactio> get transactions => _transactions;
// Define the isLoading property
  bool get isLoading => _isLoading;

  Future<void> getTransactions(String customerName,String retailerNumber) async {
    try {
      _isLoading = true; // Set isLoading to true when starting to fetch data


      final customersRef = _firestore.collection('customers');
      final snapshot =
      await customersRef.where('name', isEqualTo: customerName).where('retailerPhoneNumber', isEqualTo: retailerNumber).get();
      if (snapshot.docs.isNotEmpty) {
        final customerDoc = snapshot.docs.first;
        final customer =
        Customer.fromMap(customerDoc.data(), );
        _transactions.assignAll(customer.transactions);
      } else {
        _transactions.clear();
      }
    } catch (e) {
      print('Failed to get transactions: $e');
      _transactions.clear();
    }finally {
      _isLoading = false; // Set isLoading back to false when done fetching data
    }
  }

  Future<void> addTransaction(String retailerphone,
      String customerName, int amount, String date, String type) async {
    try {
      Get.dialog(CircularProgressIndicator());
      final customersRef = _firestore.collection('customers');
      final snapshot = await customersRef
          .where('name', isEqualTo: customerName)
          .where('retailerPhoneNumber', isEqualTo: retailerphone) // add filter for retailerPhoneNumber
          .get();
      if (snapshot.docs.isNotEmpty) {
        final customerDoc = snapshot.docs.first;
        final customer = Customer.fromMap(customerDoc.data());
        final newTransaction = Transactio(
          id: UniqueKey().toString(),
          type: type,
          amount: amount,
          date: date,
        );
        customer.transactions.add(newTransaction);
        await customerDoc.reference.update({
          'transactions': customer.transactions.map((t) => t.toMap()).toList()
        });
        Get.back();
        Get.snackbar('Success', 'Transaction added successfully.');
      } else {
        Get.back();
        Get.snackbar('Error', 'Customer not found.');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to add transaction.');
    }
  }

}
