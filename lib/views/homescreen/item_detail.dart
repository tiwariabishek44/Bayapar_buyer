import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/cart_controller.dart';
import '../../models/cart.dart';
import '../../models/product_model.dart';
class ItemDetails extends StatefulWidget {
  final ProductModel product;


  ItemDetails({
    required this.product,

  });
  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool loading = false;




  Future<String?> _getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }
  final CartController cartController = CartController();
  int _selectedVariantIndex = 0;
  int count = 1;
  int step = 1;
  void increment() {
    setState(() {
      count ++;
    });
  }
  void decrement() {
    setState(() {
      if(count>=2){
        count --;
      }
    });
  }
  void _add_to_cart(double pricee,String phoneno, String variant,String sellerphone) async {

    final cart = CartItem(
        sellerPhone: sellerphone,
        buyerShopName: '',
        productname: '${widget.product.name}',
        price: pricee*count,
        buyerPhoneNumber: phoneno,
        quantity:count,
        imageUrl: widget.product.image,
        variant: variant,
        supplierName: widget.product.supplierName

    );

    await cartController.addtocart(cart);
    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    // final String title = Get.arguments as String;


    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(elevation: 0,
          backgroundColor: whiteColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
            color: darkFontGrey, // set icon color to black
          ),
          title: Text('${widget.product.name}', style: TextStyle(color: darkFontGrey),),

        ),
        body:FutureBuilder<String?>(
          future: _getPhoneNumber(),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData) {
              final String? phoneNumber = snapshot.data;
              final double marginepercent=((widget.product.marginList[_selectedVariantIndex])/(widget.product.priceList[_selectedVariantIndex]
                  +widget.product.marginList[_selectedVariantIndex]))*100;

              return Container(
                color: Colors.blueGrey.shade50,
                width: context.screenWidth,
                height: context.height,
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(

                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.heightBox,

                                Center(
                                  child: Container(width: context.screenWidth-100,
                                      height: context.screenHeight-585,

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
                                      child: Image.network(widget.product.image,
                                        fit: BoxFit.fill,)
                                  ),
                                ),


                                10.heightBox,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:        Text(
                                    widget.product.name, style:  TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                  ),



                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Price: ',
                                            style: TextStyle(fontSize: 18),
                                          ),5.widthBox,
                                          Text(
                                            '\Rs.${widget.product.priceList[_selectedVariantIndex]}',
                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),40.widthBox,

                                      Text(
                                        'Set of : ${widget.product.mrpList[_selectedVariantIndex].toInt()} pice',
                                        style: TextStyle(fontSize: 17, color: darkFontGrey),
                                      ),40.widthBox,


                                    ],
                                  ),

                                ),
                                GridView.count(physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 2/3,
                                  children: List.generate(
                                    widget.product.variantList.length,
                                        (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedVariantIndex = index;
                                        });
                                      },
                                      child: Chip(
                                        label: Text(widget.product.variantList[index]),
                                        backgroundColor: _selectedVariantIndex == index
                                            ? Colors.blue
                                            : Colors.grey[300],
                                      ),
                                    ),
                                  ),
                                ),

                                20.heightBox,


                                Padding(
                                    padding: const EdgeInsets.all(8.0),

                                    child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color:  Color(0xfffa0606), // Use a gold color
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Text(
                                          'Rs. ${widget.product.marginList[_selectedVariantIndex]} (${
                                              marginepercent.toStringAsFixed(1)}%)',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Bold',
                                          ),
                                        ),
                                      ),

                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: decrement,
                                              child: Container(
                                                width: 42,
                                                height: 42,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 20,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              '${count}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(width: 8),
                                            InkWell(
                                              onTap: increment,
                                              child: Container(
                                                width: 42,
                                                height: 42,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 20,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )


                                ),


                                20.heightBox,

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
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
                                            Text('Category:'),
                                            Text('Biscuits', style: TextStyle(color: redColor, fontFamily: semibold,),),
                                          ],
                                        ),
                                        SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Sensitivity:'),
                                            Text('Medium Sensititvity'),
                                          ],
                                        ),
                                        SizedBox(height: 8.0),


                                        SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Warrenty:'),
                                            Text("Non Returning"),
                                          ],
                                        ),10.heightBox,

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Seller:'),
                                            Text("${widget.product.supplierName}"),
                                          ],
                                        ),



                                      ],
                                    ),
                                  ),
                                ),


                                10.heightBox,


                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Container(
                                      height: 5,
                                      color: Colors.greenAccent,
                                      width: 40,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Related Product",style: TextStyle(
                                        color: darkFontGrey, fontFamily: semibold, fontSize: 18
                                    ),),
                                  ),
                                ),10.heightBox,


                              ],
                            ),
                          ),
                        ),15.heightBox,

                        GestureDetector(
                          onTap: (){
                          setState(() {
                            loading = true;
                          });
                          String formattedPhoneNumber = phoneNumber!.substring(4); // remove the first character (i.e., '+')
                          _add_to_cart(widget.product.priceList[_selectedVariantIndex],formattedPhoneNumber,widget.product.variantList[_selectedVariantIndex],widget.product.supplierPhoneNumber);
                        },
                          child:  Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.orange, // Use Amazon's orange color for the background
                              borderRadius: BorderRadius.circular(4.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              child:loading
                                  ? Center(child: CircularProgressIndicator())
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Add to Cart: (${count}  set) totalRs ${count *widget.product.priceList[_selectedVariantIndex]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),




                      ],
                    ),
                  ),
                );

            } else {
              // Show a loading indicator until the phone number is retrieved
              return Center(child: CircularProgressIndicator());
            }
          },
        )


    );
  }
}

