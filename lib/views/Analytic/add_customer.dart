import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/retailer_detail_controller.dart';
import '../../models/customer_data.dart';

class AddCustomerPage extends StatefulWidget {
  final void Function() onCustomerAdded;
  final String retailer;

  AddCustomerPage({Key? key, required this.onCustomerAdded,required this.retailer}) : super(key: key);

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final CustomersService _controller = Get.find<CustomersService>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Customer',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter customer name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name.';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Text(
            'Phone Number',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter customer phone number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a phone number.';
              }
              return null;
            },
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: ()async{
              if (_formKey.currentState!.validate()) {
                final customer = Customer(
                  retailerPhoneNumber: widget.retailer,
                  name: _nameController.text,
                  phoneNumber: _phoneController.text,
                  transactions: [],
                  credit: 0,
                );
                await _controller.addCustomer(customer);
                    widget.onCustomerAdded();
                    Navigator.pop(context);
              }

            },
            child: Text(
              'Save',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: Size(
                double.infinity,
                50,
              ),
            ),
          ),
        ],
      ),
        ),

      ),
    );
  }
}



