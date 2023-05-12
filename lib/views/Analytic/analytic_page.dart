import 'package:bayapar_retailer/consts/consts.dart';
import 'package:bayapar_retailer/views/Analytic/udaro_analytic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/retailer_detail_controller.dart';
import '../../models/customer_data.dart';
import '../../models/retailer_models.dart';
import 'account_details.dart';
import 'add_customer.dart';
import 'package:velocity_x/velocity_x.dart';





class Analytic extends StatefulWidget {
  @override
  State<Analytic> createState() => _AnalyticState();
}

class _AnalyticState extends State<Analytic> {
  final CustomersService _controller = Get.put(CustomersService());

  String phoneNumber='';

  late final int pending ;

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
        _controller.getCustomers(phoneNumber);

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        actions:  [
          GestureDetector(
            onTap: (){
              Get.to(()=>Udaro_analytic());
            },
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(Icons.analytics,color: darkFontGrey,size: 30,),
            ),
          )
        ],
        elevation: 0.5,
        title: Text("Credit Analytic", style:
        TextStyle(fontFamily: semibold,color: redColor),),
      ),

        body:  Obx(() {
        final customers = _controller.customers;
        if (customers.isEmpty) {
          return Center(
            child: Text("No customers added. Add some!"),
          );
        } else {
          customers.sort((a, b) => a.name.compareTo(b.name));

          int totalUdaro = 0; // initialize total udaro to 0




          return Container(     width: context.screenWidth,color: whiteColor,
            height: context.height,
            child: Column(
              children: [

                Column(
                  children: [
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
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Customers",style: TextStyle(
                            color: darkFontGrey, fontFamily: semibold, fontSize: 20
                        ),),
                      ),
                    ),
                  ],
                ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).
                roundedSM.padding(const EdgeInsets.all(12)).make(),

                10.heightBox,
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: _controller.customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index];

                      int totaludaro = 0;
                      int totalCash = 0;
                      for (var transaction in customer.transactions) {
                        if (transaction.type == 'udaro' && transaction.amount != 0) {
                          totaludaro += transaction.amount;
                        } else if (transaction.type == 'cash') {
                          totalCash += transaction.amount;
                        }
                      }
                      int udaropending = totaludaro - totalCash;
                      totalUdaro += udaropending; // add the udaropending for this customer to the total udaro
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>Account_details(
                            customer: customer,
                            onCustomerAdded: () {
                              setState(() {
                                _controller.getCustomers(phoneNumber);
                              });
                            },

                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: Container(
                            padding: EdgeInsets.all(19),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(Icons.person_outline),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        customer.name,
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Phone no: ${customer.phoneNumber}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      5.heightBox,
                                      Text(
                                        'Pending udaro Rs-${udaropending}',
                                        style: TextStyle(fontSize: 18,color:Color(0xffff2d55)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red, // set the background color to red
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddCustomerPage(
            retailer: phoneNumber,
            onCustomerAdded: () {
              setState(() {
                _controller.getCustomers(phoneNumber);
              });
            },
          ));
        },
      ),

    );
  }
}

