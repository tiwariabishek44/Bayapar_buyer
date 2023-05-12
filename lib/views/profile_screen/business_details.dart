import 'package:bayapar_retailer/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/retailer_detail_controller.dart';
import '../../models/retailer_models.dart';
import '../homescreen/detail_input_screen.dart';



class StoreDetailsPage extends StatefulWidget {
  @override
  State<StoreDetailsPage> createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  final FirebaseController _firebaseController = Get.find();
  String? phoneNumber ='';
  Future<String?> _getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  @override
  void initState() {
    super.initState();

    _getPhoneNumber().then((value) {
      setState(() {
        phoneNumber = value!.substring(4);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: darkFontGrey, // set icon color to black
        ),
        title: Text(
          "Retailer",
          style: TextStyle(fontFamily: semibold, color: redColor),
        ),

      ),
      body: FutureBuilder(
        future: _firebaseController.getRetailerData('${phoneNumber}'),
        builder: (BuildContext context, AsyncSnapshot<RetailerModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null) {
            return Center(child: Text('Retailer data not found.'));
          }
          final retailer = snapshot.data!;
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Retailer Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                      SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Owner Name:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              retailer.ownerName,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Shop Name:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              retailer.shopName,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),





                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                          flex: 1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shop Address:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${retailer.address} , ${retailer.municipality}, ${retailer.street},',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Contact Information',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[600],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Phone Number:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  retailer.phoneNumber,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),)]
                          )
                      ),
                      GestureDetector(
                        onTap:  (){Get.to(()=> Business_details_input());},
                        child: Icon(Icons.edit),
                      ),

                    ]),


                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


