import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/order_controller.dart';
import 'order_detail.dart';
import 'order_status.dart';


class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

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
            child: Text("There is no any order"),
          );
        } else {
          final reversedOrders = orderController.orders
              .where((order) => !order.isOnRoad)
              .toList()
              .toList();
          if (reversedOrders.isEmpty) {
            return Center(
              child: Text('No orders to show'),
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
                            order.isPackaging == false ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Order'),
                                        content: Text('Are you sure you want to delete this order?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              orderController.deleteOrder(order);
                                              setState(() {
                                                orderController.getorders(phoneNumber);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Image.asset(
                                  icTrash,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ) : Container(),
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
                        5.heightBox,
                        OrderStatusWidget(orderStatusList: orderStatusList(order)),
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
