import 'package:bayapar_retailer/consts/consts.dart';
import 'package:bayapar_retailer/consts/lists.dart';
import 'package:bayapar_retailer/views/homescreen/product_list_page.dart';
import 'package:get/get.dart';
import 'cart_screen2.dart';



class CatagoryDetails extends StatefulWidget {

  const CatagoryDetails({Key? key}) : super(key: key);

  @override
  State<CatagoryDetails> createState() => _CatagoryDetailsState();
}

class _CatagoryDetailsState extends State<CatagoryDetails> {

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          "${title}",
          style: TextStyle(
            color: darkFontGrey, // set text color to black
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: darkFontGrey, // set icon color to black
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Image.asset(icCart,color: darkFontGrey,),
                onPressed: () {
                  Get.to(CartScreen2(),);
                },
                color: Colors.black, // set icon color to black
              ),
            ],
          ),5.widthBox,
        ],
      ),
      body: Container(
        color: Colors.blueGrey.shade50,
        width: context.screenWidth,
        height: context.height,
        child: SafeArea(
          child: Column(
            children: [
              20.heightBox,



              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                          child: Text("Products",style: TextStyle(
                              color: darkFontGrey, fontFamily: semibold, fontSize: 18
                          ),),
                        ),
                      ),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,mainAxisSpacing: 10,
                            crossAxisSpacing: 8,mainAxisExtent: 200) ,
                            itemBuilder: (context, index){
                              final image = imagelist[index];

                              return GestureDetector(
                                  onTap: (){
                                    Get.to(()=>Product_list(subcategory: 'fry', pagetitle: 'Digestive',) );

                                  },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: AssetImage(image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );

                            }),
                      ),
                      20.heightBox,


                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
