import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/cart_controller.dart';
import '../../models/cart.dart';
import '../../widget/our_button.dart';
import 'package:flutter/material.dart';
import 'order_conform.dart';


class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String phoneNumber ='';
  final _cartController = Get.find<CartController>();
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
        _cartController.getCartsItems(phoneNumber);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: whiteColor,
        automaticallyImplyLeading: true,
        elevation: 0.5,


        title: Text("bayapar cart", style:
        TextStyle(fontFamily: semibold,color: redColor),),
      ),
      body: Obx(() {
        if (_cartController.carts.isEmpty) {
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 48,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text('No Item in cart.'),
              ],
            ),
          );
        } else {
          // Get a list of unique supplier names from the cart items
          List<String> supplierNames = _cartController.carts.map((cart) => cart.supplierName).toSet().toList();

          // Create a container for each supplier with their products listed
          return ListView.builder(
            itemCount: supplierNames.length,
            itemBuilder: (context, supplierIndex) {
              // Get the cart items for the current supplier
              List<CartItem> supplierCartItems = _cartController.carts.where((cart) => cart.supplierName == supplierNames[supplierIndex]).toList();

              // Create a container for the supplier with their products listed
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supplier Name: ${supplierNames[supplierIndex]}',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: supplierCartItems.length,
                      itemBuilder: (context, productIndex) {
                        final cartItem = supplierCartItems[productIndex];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    cartItem.imageUrl,
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem.productname,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: regular,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Variant: ${cartItem.variant}',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Quantity: ${cartItem.quantity} set',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: ()async {
                                    await _cartController.deletecartIte(cartItem);
                                    setState(() {
                                      _cartController.getCartsItems(phoneNumber);

                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                          ],
                        );
                      },
                    ),

                    15.heightBox,
                    SizedBox(
                      height: 50,
                      width: context.screenWidth - 30,
                      child: ourbutton(
                        color: redColor,
                        onpressed: () {
                          // Get the cart tems for the current supplier
                          List<CartItem> supplierCartItems = _cartController.carts.where((cart) => cart.supplierName == supplierNames[supplierIndex]).toList();

                          Get.to(() => OrderConfirm(

                            updateCartList:  () {
                              _cartController.getCartsItems(phoneNumber);
                              // Your code to update the product list screen goes here
                            },
                            sellerphone: '${supplierCartItems[0].sellerPhone}',
                            buyerPhoneNo: '$phoneNumber',
                            supplierName: '${supplierNames[supplierIndex]}',
                            supplierProducts: supplierCartItems,
                          ));
                        },
                        textcolor: whiteColor,
                        title: "Proceed to shipping",
                      ),

                    ),
                  ],
                ),
              );
            },
          );
        }
      }),



    );
  }
}