import 'package:bayapar_retailer/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../category/category controller.dart';
import '../../widget/applogo_widgit.dart';
import '../auth screen/login_screen.dart';
import '../homescreen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final categoryController = Get.find<CategoriController>();
  @override
  void initState() {
    super.initState();
    setState(() {
      categoryController.getCategories();

    });
  }

  @override
  Widget build(BuildContext context) {
    // Delay for 2 seconds before navigating to the next screen
    Future.delayed(const Duration(seconds: 1), () async {
      // Check if the user's phone number is stored in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phoneNumber = prefs.getString('phone');

      // Navigate to the HomePage if the phone number is stored, otherwise navigate to the LoginPage
      if (phoneNumber != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });

    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Image.asset(
          bayapar,
          height: MediaQuery.of(context).size.height / 1,
          width: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }
}
