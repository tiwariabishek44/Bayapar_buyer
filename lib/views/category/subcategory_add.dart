import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';

import '../../controller/category_controller.dart';
import '../../models/category_model.dart';
import '../homescreen/cart_screen2.dart';
import '../homescreen/product_list_page.dart';


class SubcategoryPage extends StatefulWidget {
  final String mainCategory;

  SubcategoryPage({required this.mainCategory});

  @override
  _SubcategoryPageState createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends State<SubcategoryPage> {
  final SubcategoryController _subcategoryController = SubcategoryController();
  late Future<List<Subcategory>> _subcategoriesFuture;

  @override
  void initState() {
    super.initState();
    _subcategoriesFuture = _subcategoryController.getSubcategories(widget.mainCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          "{title}",
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
      body: FutureBuilder<List<Subcategory>>(
        future: _subcategoriesFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Subcategory>> snapshot) {
          if (snapshot.hasData) {
            final List<Subcategory> subcategories = snapshot.data!;
            return Container(
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
                                  itemCount: subcategories.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,mainAxisSpacing: 10,
                                      crossAxisSpacing: 8,mainAxisExtent: 180) ,
                                  itemBuilder: (context, index){
                                    final Subcategory subcategory = subcategories[index];
                                    return GestureDetector(
                                      onTap: (){
                                        Get.to(()=>Product_list(subcategory: 'fry', pagetitle: 'Noodles',) );

                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(subcategory.subimage,height:100 ,
                                            width: 200,
                                            fit: BoxFit.cover,),
                                          const Spacer(),
                                          "Laptop 4GB".text.fontFamily(regular).
                                          color(darkFontGrey).make(),
                                          20.heightBox,
                                        ],
                                      ).box.green50.margin(const EdgeInsets.symmetric(horizontal: 4)).
                                      roundedSM.padding(const EdgeInsets.all(12)).make(),
                                    );

                                  }),
                            ),
                            20.heightBox,
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
                                child: Text("Shop by Brand",style: TextStyle(
                                    color: darkFontGrey, fontFamily: semibold, fontSize: 18
                                ),),
                              ),
                            ),
                            5.heightBox,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: 4,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,mainAxisExtent: 180) ,
                                  itemBuilder: (context, index){
                                    return GestureDetector(
                                      onTap: (){
                                        Get.to(()=>Product_list(subcategory: 'fry',pagetitle: 'Noodles',),);
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(nesle,height:100 ,
                                            width: 200,
                                            fit: BoxFit.cover,),
                                          const Spacer(),
                                          20.heightBox,





                                        ],
                                      ).box.sky50.margin(const EdgeInsets.symmetric(horizontal: 4)).
                                      roundedSM.padding(const EdgeInsets.all(12)).make(),
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
            );

            //
            //   GridView.builder(
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 10,
            //     crossAxisSpacing: 10,
            //   ),
            //   itemCount: subcategories.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     final Subcategory subcategory = subcategories[index];
            //     return Card(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Image.network(subcategory.subimage),
            //
            //         ],
            //       ),
            //     );
            //   },
            // );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}





