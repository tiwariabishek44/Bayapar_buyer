import 'package:bayapar_retailer/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consts/colors.dart';
import '../consts/lists.dart';
import '../controller/retailer_detail_controller.dart';
import '../models/retailer_models.dart';
import '../views/auth screen/login_screen.dart';
import '../views/homescreen/category_detail_page.dart';
import '../views/homescreen/product_list_page.dart';
import '../views/profile_screen/about_bayapar.dart';
import '../views/profile_screen/business_details.dart';
import '../views/profile_screen/contact_us.dart';
import '../views/profile_screen/policies.dart';
import '../views/profile_screen/terms_of_use.dart';
import 'category controller.dart';
class CategoriesPage extends StatefulWidget {
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final categoryController = Get.find<CategoriController>();
  final FirebaseController _firebaseController = Get.find();
  String? phoneNumber ='';
  Future<String?> _getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }
  late Future<void> _categoryFuture = Future((){}); // Initialize with an empty future


  void logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    showDialog(
      context: context,
      builder: (BuildContext context)  {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Log out"),
              onPressed: () {
                // Add code here to handle the logout action
                prefs.remove('phone');
                Get.offAll(()=>LoginScreen());
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();

    _getPhoneNumber().then((value) {
      setState(() {
        phoneNumber = value!.substring(4);
        _firebaseController.getRetailerData('${phoneNumber}');
        _categoryFuture =categoryController.getCategories();

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
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
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xffff2d55), // set the background color to white
                ),
                accountName: FutureBuilder(
                  future: _firebaseController.getRetailerData('${phoneNumber}'),
                  builder: (BuildContext context, AsyncSnapshot<RetailerModel?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      );
                    }
                    if (snapshot.hasError || snapshot.data == null) {
                      return Text(
                        'No retailer data found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      );
                    }
                    final retailer = snapshot.data!;
                    return Text(
                      retailer.ownerName,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: semibold,
                      ),
                    );
                  },
                ),
                accountEmail: FutureBuilder(
                  future: _firebaseController.getRetailerData('${phoneNumber}'),
                  builder: (BuildContext context, AsyncSnapshot<RetailerModel?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {

                      return Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      );
                    }
                    if (snapshot.hasError || snapshot.data == null) {
                      return Text(
                        'No retailer data found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      );
                    }
                    final retailer = snapshot.data!;
                    return Text(
                      retailer.shopName,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: semibold,
                      ),
                    );
                  },
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.person, size: 60, color: Colors.blue),
                )


            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(() => StoreDetailsPage(),
                              arguments: "${profileButtonList[index]}");
                          break;
                        case 1:
                          Get.to(() => Contact_us(),
                              arguments: "${profileButtonList[index]}");
                          break;
                        case 2:
                          Get.to(() => TermsOfUsePage()) ;
                          break;
                        case 3:
                          Get.to(() =>Policies(),arguments: '${profileButtonList[index]}');
                          break;
                        case 4:
                          Get.to(() => About(),arguments: '${profileButtonList[index]}'
                          );
                          break;
                        case 5:
                          logout(); // Call the logout function here
                          break;
                      }
                    },
                    leading: Image.asset(
                      profileButtonicon[index],
                      width: 25,
                    ),
                    title: profileButtonList[index]
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: lightGrey,
                  );
                },
                itemCount: profileButtonList.length,
              ).box.white.rounded.margin(const EdgeInsets.only(top: 10)).padding(const EdgeInsets.all(5)).shadowSm.make(),
            ),
          ],
        ),
      ),

      body:  FutureBuilder<void>(
        future: _categoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (categoryController.categories.isEmpty) {
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
                    Text('No products found.'),
                  ],
                ),
              );
            } else {
              return   Container(
                color: Colors.blueGrey.shade50,
                width: context.width,
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
                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Grocessery Items",style: TextStyle(
                                color: darkFontGrey, fontFamily: semibold,
                                fontSize: 20
                            ),),
                          ),
                        ),
                        10.heightBox,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: categoryController.categories.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 190),
                            itemBuilder: (context, index) {
                              final categories = categoryController.categories;
                              categories.sort((a, b) => a.range.compareTo(b.range));
                              final category = categories[index];
                              return GestureDetector(
                                onTap: (){
                                  Get.to(()=>  Product_list(subcategory: '${category.name}', pagetitle: category.name,));

                                }
                                ,
                                child: Image.network(
                                  category.image,
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          ),
                        ),


                      ],

                    ),
                  ),
                ),
              );

            }
          }
        },
      ),





    );
  }
}
