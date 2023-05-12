import 'package:bayapar_retailer/consts/consts.dart';
import 'completeorder.dart';
import 'orderpage.dart';

import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {

  MyOrder({Key? key,}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0.1,
          automaticallyImplyLeading: false,
          title: Text(
            'Orders',  style: TextStyle(fontFamily: semibold, color: redColor),
        ),

          bottom: const TabBar(
            tabs: [
              Tab(text: ' Orders'),
              Tab(text: 'Completed Orders'),
            ],
            labelColor: darkFontGrey, // set text color of selected tab to white
            unselectedLabelColor: darkFontGrey, // set text color of unselected tabs to white with opacity of 0.5
            indicatorColor: redColor,
          ),
        ),
        body:  TabBarView(
          children: [
            OrderPage(),
            CompletedOrdersPage(),
          ],
        ),
      ),
    );
  }
}


