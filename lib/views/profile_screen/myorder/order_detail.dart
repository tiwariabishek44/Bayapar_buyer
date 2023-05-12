

import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';

import '../../../consts/lists.dart';
import '../../../models/order_model.dart';
import 'order_status.dart';


class Order_details extends StatefulWidget {
  final Orders order;
  const Order_details({Key? key, required this.order}) : super(key: key);

  @override
  State<Order_details> createState() => _Order_detailsState();
}

class _Order_detailsState extends State<Order_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(backgroundColor: whiteColor,
          elevation: 0.1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
            color: darkFontGrey, // set icon color to black
          ),
          title: Text("Order Confirm", style:
          TextStyle(fontFamily: semibold,color: redColor),),
        ),

        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderStatusWidget(orderStatusList: orderStatusList(widget.order)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.order.cartItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 100,
                    ),
                    itemBuilder: (context, index){
                      final items = widget.order.cartItems[index];
                      return GestureDetector(

                        child: ListTile(
                          leading: Image.network(items.imageUrl),
                          title: Text("${items.productname}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quantity: ${items.quantity} set'),
                              5.heightBox,
                              Text('Variant: ${items.variant}'),
                              5.heightBox,
                              Text('Price: Rs.${items.price}'),
                            ],
                          ),
                        ).box.green50.margin(const EdgeInsets.symmetric(horizontal: 4)).
                        roundedSM.padding(const EdgeInsets.all(8)).make(),
                      );
                    },
                  ),


                ),
                10.heightBox,// Accounting container
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Address:'),
                              Text('${widget.order.address}', style: TextStyle(color: redColor, fontFamily: semibold,),),
                            ],
                          ),5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Municipality'),
                              Text('${widget.order.municipality}'),
                            ],
                          ),5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Street'),
                              Text('${widget.order.street}'),
                            ],
                          ),5.heightBox,

                        ]),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Details', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Code:'),
                              Text('${widget.order.id}', style: TextStyle(color: redColor, fontFamily: semibold,),),
                            ],
                          ),5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date:'),
                              Text('${widget.order.orderDate}'),
                            ],
                          ),5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Time:'),
                              Text('${widget.order.time}'),
                            ],
                          ),5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Payment:'),
                              Text('${widget.order.paymentMethod}'),
                            ],
                          ),5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Suppilers:'),
                              Text('${widget.order.supplierName}'),
                            ],
                          ),5.heightBox,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal:'),
                              Text('Rs .${widget.order.totalPrice+widget.order.discount}'),
                            ],
                          ),
                          SizedBox(height: 8.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Logistic Cost:'),
                              Text('Rs.00'),
                            ],
                          ),
                          SizedBox(height: 8.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Discount:'),
                              Text('Rs.${widget.order.discount}'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Grand Total:'),
                              Text('Rs.${widget.order.totalPrice}'),
                            ],
                          ),
                        ]),),
                ),

              ]),
        )


    );
  }
}