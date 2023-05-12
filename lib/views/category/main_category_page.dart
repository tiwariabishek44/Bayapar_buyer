

import 'package:bayapar_retailer/views/category/subcategory_add.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../consts/lists.dart';
import '../../controller/category_controller.dart';
import '../../models/category_model.dart';
import '../homescreen/category_detail_page.dart';

class Categoryscreen extends StatefulWidget {

  const Categoryscreen({Key? key, }) : super(key: key);

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey.shade50,
        elevation: 0.1,
        iconTheme: IconThemeData(
            color: darkFontGrey
        ),

        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Perform search action
              },
            ),
          ),
        ],

      ),
      body: FutureBuilder<List<Category>>(
        future: CategoryController().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }

          final categories = snapshot.data!;

          return
            Container(
              color: Colors.blueGrey.shade50,
              width: context.screenWidth,
              height: context.height,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [   Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Food",style: TextStyle(
                            color: darkFontGrey, fontFamily: semibold, fontSize: 18
                        ),),
                      ),
                    ),
                      5.heightBox,
                      VxSwiper.builder(
                        height: 200,
                        aspectRatio: 16/9,
                        viewportFraction: 0.97,
                        initialPage: 4,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        enlargeCenterPage: true,
                        itemCount: sliderLIst.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            sliderLIst[index],
                            fit: BoxFit.fill,
                          ).box.rounded.clip(Clip.antiAlias).margin(
                            const EdgeInsets.symmetric(horizontal: 7),
                          ).make();
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          categories.sort((a, b) => a.rank.compareTo(b.rank));
                          final category = categories[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.heightBox,
                              Container(
                                color: Colors.blueGrey.shade50,
                                width: context.screenWidth,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Container(
                                        height: 5,
                                        color: Colors.greenAccent,
                                        width: 40,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("${category.name}",style: TextStyle(
                                            color: darkFontGrey, fontFamily: semibold,
                                            fontSize: 20
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              10.heightBox,
                              const SizedBox(height: 16.0),
                              GridView.builder(
                                itemCount: category.items.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,mainAxisSpacing: 10,
                                    crossAxisSpacing: 8,mainAxisExtent: 200) ,
                                itemBuilder: (context, index){
                                  final item = category.items[index];
                                  return GestureDetector(
                                    onTap: (){
                                      Get.to(()=> SubcategoryPage(mainCategory:item.name ),);
                                    },
                                    child:    Image.network(item.image,

                                      fit: BoxFit.fill,),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
