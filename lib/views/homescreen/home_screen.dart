import 'package:bayapar_retailer/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/lists.dart';
import '../../controller/retailer_detail_controller.dart';

import '../../models/retailer_models.dart';
import '../../widget/our_button.dart';
import '../category/subcategory_add.dart';
import '../profile_screen/about_bayapar.dart';
import '../profile_screen/policies.dart';
import '../profile_screen/shop_overview.dart';
import '../profile_screen/terms_of_use.dart';
import 'detail_input_screen.dart';
import '../auth screen/login_screen.dart';
import '../profile_screen/business_details.dart';
import '../profile_screen/contact_us.dart';
import '../profile_screen/myorder/my_order.dart';
import 'category_detail_page.dart';

import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseController _firebaseController = Get.find();
  String? phoneNumber ='';
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
        _firebaseController.getRetailerData('${phoneNumber}');
      });
    });
  }

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

      body:FutureBuilder(
        future: _firebaseController.getRetailerData('${phoneNumber}'),
    builder: (BuildContext context, AsyncSnapshot<RetailerModel?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    }
    final retailer = snapshot.data;
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
                  children: [
                    5.heightBox,
                    retailer == null ?ourbutton(
                        color: redColor,
                        onpressed:  (){Get.to(()=> Business_details_input());},
                        title: "Enter the business details",
                        textcolor: darkFontGrey
                    ): SizedBox(),
                    Padding(
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
                        child: Text("Drinks & Snacks",style: TextStyle(
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
                          itemCount: drinksandSnacks.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,mainAxisSpacing: 10,
                              crossAxisSpacing: 8,mainAxisExtent: 200) ,
                          itemBuilder: (context, index){
                            final maincategory = catagory_list[index];
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=>const CatagoryDetails(), arguments: "Drinks & Snacks");
                              },
                              child:   Image.asset(drinksandSnacks[index],

                                fit: BoxFit.fill,),
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
                        child: Text("Packaged Food",style: TextStyle(
                            color: darkFontGrey, fontFamily: semibold, fontSize: 20
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
                              crossAxisSpacing: 8,mainAxisExtent: 200) ,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=> CatagoryDetails(),
                                    // arguments:"Packaged Food"
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Image.network('https://cdn.shopify.com/s/files/1/0507/3059/8568/products/meat-masala-50g-current-baazwsh-507275.jpg?v=1676587728',

                                    height: 150,
                                    fit: BoxFit.cover,),
                                  // Image.asset(imgFc1,height:100 ,
                                  //   width: 200,
                                  //   fit: BoxFit.cover,),






                                ],
                              ).box.sky50.margin(const EdgeInsets.symmetric(horizontal: 4)).
                              roundedSM.padding(const EdgeInsets.all(12)).make(),
                            );

                          }),
                    ),
                    20.heightBox,
                    VxSwiper.builder(
                      height: 150,
                      aspectRatio: 0.2,
                      viewportFraction: 0.97,
                      initialPage: 4,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      enlargeCenterPage: true,
                      itemCount: secondsliderLIst.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          sliderLIst[index],
                          fit: BoxFit.fill,
                        ).box.rounded.clip(Clip.antiAlias).margin(
                          const EdgeInsets.symmetric(horizontal: 8),
                        ).make();
                      },
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
                        child: Text("Food Grains, Oil & Masala",style: TextStyle(
                            color: darkFontGrey, fontFamily: semibold, fontSize: 20
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
                            final maincategory =catagory_list[index];
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=>const CatagoryDetails(), arguments: "${maincategory}");
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(nesle,height:100 ,
                                    width: 200,
                                    fit: BoxFit.cover,),
                                  const Spacer(),
                                  "${maincategory}".text.fontFamily(regular).
                                  color(darkFontGrey).make(),
                                  20.heightBox,
                                ],
                              ).box.sky50.margin(const EdgeInsets.symmetric(horizontal: 4)).
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
                        child: Text("Personal Care",style: TextStyle(
                            color: darkFontGrey, fontFamily: semibold, fontSize: 20
                        ),),
                      ),
                    ),
                    5.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: personal_care.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,mainAxisSpacing: 8,
                              crossAxisSpacing: 8,mainAxisExtent: 170) ,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=>const CatagoryDetails(), arguments: "Personal Care");
                              },
                              child:Image.asset(personal_care[index]),
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
                        child: Text("Home Care",style: TextStyle(
                            color: darkFontGrey, fontFamily: semibold, fontSize: 20
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
                                Get.to(()=>const CatagoryDetails(), arguments: "Home Care");
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(nesle,height:100 ,
                                    width: 200,
                                    fit: BoxFit.cover,),
                                  const Spacer(),
                                  "Laptop 4GB".text.fontFamily(regular).
                                  color(darkFontGrey).make(),
                                  20.heightBox,


                                  10.heightBox,




                                ],
                              ).box.sky50.margin(const EdgeInsets.symmetric(horizontal: 4)).
                              roundedSM.padding(const EdgeInsets.all(12)).make(),
                            );

                          }),
                    ),



                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );


        }
      ),
    );
  }
}
