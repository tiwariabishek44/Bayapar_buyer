import 'package:bayapar_retailer/consts/consts.dart';
import 'package:bayapar_retailer/controller/cart_controller.dart';
import 'package:bayapar_retailer/controller/order_controller.dart';
import 'package:bayapar_retailer/models/order_model.dart';
import 'package:bayapar_retailer/widget/our_button.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/retailer_detail_controller.dart';
import '../../models/cart.dart';
import '../../models/retailer_models.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:bayapar_retailer/models/discount_model.dart';
class OrderConfirm extends StatefulWidget {
  final VoidCallback? _updateCartList;
  final String sellerphone;
  final String buyerPhoneNo;
  final String supplierName;


  final List<CartItem> supplierProducts;


   OrderConfirm({Key? key, required this.buyerPhoneNo,required this.sellerphone,
    required this.supplierName,

    required this.supplierProducts,VoidCallback? updateCartList})   :
     _updateCartList = updateCartList,  super(key: key);

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  bool loading = false;
  final FirebaseController _firebaseController = Get.find();
  String? phoneNumber ='';
  Future<String?> _getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  String _dcamount = '';


  Future<void> _fetchDA() async {
    var da = await DAController().getDA();
    setState(() {
      _dcamount = da?.dcamount ?? '';
    });
  }
  @override
  void initState() {
    super.initState();
    _fetchDA();
    _getPhoneNumber().then((value) {
      setState(() {
        phoneNumber = value!.substring(4);
      });
    });
  }
  bool isloading = false;

  NepaliDateTime _nepaliDate = NepaliDateTime.now();

  String getCurrentNepaliTime() {
    DateTime localTime = _nepaliDate.toDateTime();
    // ignore: deprecated_member_use
    NepaliDateTime nepaliTime = NepaliDateTime.fromDateTime(localTime);
    String formattedTime = NepaliDateFormat('hh:mm a').format(nepaliTime);
    return formattedTime;
  }

  final OrderController _orderController = OrderController();

  final CartController _cartController =CartController();

  double get total {
    double sum = 0;
    for (CartItem item in widget.supplierProducts) {
      sum += item.price ;
    }
    return sum;
  }
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    int dcAmountInt = int.tryParse(_dcamount) ?? 0;
    return Scaffold(
        backgroundColor: whiteColor,
        appBar:AppBar(
          backgroundColor: whiteColor,
          elevation: 0.1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
            color: darkFontGrey, // set icon color to black
          ),
          title: Text("Order Confirm ", style: TextStyle(fontFamily: semibold,color: redColor),),
          actions: [
            IconButton(
              icon: Icon(Icons.phone,color: Colors.red,),
              // ignore: deprecated_member_use
              onPressed: () async{

                FlutterPhoneDirectCaller.callNumber(widget.sellerphone);


              }
            ),
          ],
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
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: widget.supplierProducts.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 100,
                        ),
                        itemBuilder: (context, index){

                          final product = widget.supplierProducts[index];
                          // Example values


                          return GestureDetector(

                            child: ListTile(
                              leading: Image.network(product.imageUrl),
                              title: Text("${product.productname}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Variant:  ${product.variant }'),

                                  Text('Quantity: ${product.quantity} set'),
                                  Text('Total Price: \Rs  ${product.price }'),
                                ],
                              ),
                            ).box.green50.margin(const EdgeInsets.symmetric(horizontal: 4)).
                            roundedSM.padding(const EdgeInsets.all(8)).make(),
                          );
                        },
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
                                Text('Accounting', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                SizedBox(height: 12.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Suppyler name:'),
                                    Text(widget.supplierName, style: TextStyle(color: redColor, fontFamily: semibold,),),
                                  ],
                                ),5.heightBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Date:'),
                                    Text('${_nepaliDate.year}-${_nepaliDate.month}-${_nepaliDate.day}'),
                                  ],
                                ),5.heightBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Time:'),
                                    Text('${getCurrentNepaliTime()}'),
                                  ],
                                ),5.heightBox,

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Subtotal:'),
                                    Text('\Rs.${total}'),
                                  ],
                                ),
                                SizedBox(height: 8.0),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Logistic Cost:'),
                                    Text('\Rs.00.00'),
                                  ],
                                ),8.heightBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Discount:'),
                                    Text('\Rs.00.00'),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Grand Total:'),
                                    Text('\Rs.${total}'),
                                  ],
                                ),]),

                        ),
                      ),


                      Container(width: context.screenWidth-30,
                        height: context.screenWidth-180,
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping Information',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Phone No :- ${widget.buyerPhoneNo}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Shop Name  :-${retailer.shopName}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Address:  :-123 Main Street',
                              style: TextStyle(fontSize: 16.0),
                            ),

                            SizedBox(height: 8.0),
                            Text(
                              'Municipaliry : ${retailer.municipality}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Street : ${retailer.street}',
                              style: TextStyle(fontSize: 16.0),
                            ),


                          ],
                        ),
                      ),

                      Container(width: context.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          'Get discount in amount more than Rs $dcAmountInt',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),10.heightBox,

              total >=dcAmountInt?Theme(
              data: ThemeData(
              unselectedWidgetColor: whiteColor,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber[600],
                ),
                child: CheckboxListTile(
                  title: Text(
                    'Ask discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: Colors.amber[600],
                ),
              ),
            ):Container(),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              isloading = true;
                            });

                            final order = Orders(
                              isDiscount: isChecked,
                              unitQuantity: 23,
                              unitType: 'perpice',
                              discount: 0,
                              sellerPhone: widget.supplierProducts[0].sellerPhone,
                              buyerPhone: widget.buyerPhoneNo,
                              supplierName: widget.supplierName,
                              retailerShopName: retailer.shopName,
                              cartItems: widget.supplierProducts,
                              municipality: retailer.municipality,
                              street: retailer.street,
                              address: retailer.street,
                              totalPrice: total,
                              orderDate: '${_nepaliDate.year}-${_nepaliDate.month}-${_nepaliDate.day}',
                              paymentMethod: 'COD',
                              isConfirmed: false,
                              isPackaging: false,
                              isOnRoad: false,
                              time: '${getCurrentNepaliTime()}',
                            );

                            await _orderController.addOrders(order);

                            await _cartController.deletecartItem(widget.supplierProducts);


                            if (widget._updateCartList != null) {
                              widget._updateCartList!();
                            }
                            Navigator.pop(context);

                          },
                          child: loading
                              ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Text(
                            'Order',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Color(0xffff2d55),
                          elevation: 0,
                          minWidth: 400,
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),



                    ],
                  )
              ),
            );
          },
        ),
    );
  }
}
