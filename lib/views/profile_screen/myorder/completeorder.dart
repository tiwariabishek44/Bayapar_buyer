import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/order_controller.dart';
import '../../../models/order_model.dart';
import 'order_detail.dart';



class CompletedOrdersPage extends StatefulWidget {


  @override
  State<CompletedOrdersPage> createState() => _CompletedOrdersPageState();
}

class _CompletedOrdersPageState extends State<CompletedOrdersPage> {
  NepaliDateTime _nepaliDate = NepaliDateTime.now();

  String phoneNumber ='';
  final orderController = Get.find<OrderController>();
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
        orderController.getorders(phoneNumber);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,

      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final reversedOrders = orderController.orders
              .where((order) => order.isOnRoad==true)
              .toList()
              .reversed
              .toList();
          if (reversedOrders.isEmpty) {
            return Center(
              child: Text('No orders completed to show'),
            );
          }

          return ListView.builder(
            itemCount: reversedOrders.length,
            itemBuilder: (context, index) {
              final order = reversedOrders[index];
              return InkWell(
                onTap: () {
                  Get.to(() => Order_details(order: order,));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order ID: ${order.id}",
                              style: TextStyle(
                                fontFamily: semibold,
                                fontSize: 16,
                                color: darkFontGrey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                icTrash,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        Text(
                          "Shop: ${order.retailerShopName}",
                          style: TextStyle(
                            color: redColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        5.heightBox,
                        Text(
                          "Total: Rs. ${order.totalPrice}",
                          style: TextStyle(
                            color: darkFontGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        5.heightBox,
                        Text(
                          "Date: ${order.orderDate}",
                          style: TextStyle(
                            color: darkFontGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),5.heightBox,
                        Text(
                          "Date: ${order.time}",
                          style: TextStyle(
                            color: darkFontGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );

  }
}
