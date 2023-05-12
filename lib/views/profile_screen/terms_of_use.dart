import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/colors.dart';
import '../../consts/styles.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: darkFontGrey, // set icon color to black
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,elevation: 0.6,
        title: Text("Order Confirm", style:
        TextStyle(fontFamily: semibold,color: redColor),),      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Introduction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Welcome to Bayapar, our B2B ecommerce platform connecting retailers and FMCG suppliers. By using our platform, you agree to follow these terms of use.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Eligibility',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'You must be a registered business entity and have the legal capacity to enter into a binding agreement in your jurisdiction to use our platform.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),

              Text(
                'Payment and Invoicing',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'All payments must follow agreed payment terms between you and the supplier. We are not responsible for payment disputes between you and the supplier.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

              SizedBox(height: 16.0),

              Text(
                'Returns and Refunds',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Returns and refunds are subject to supplier policies. We are not responsible for disputes regarding returns or refunds.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
