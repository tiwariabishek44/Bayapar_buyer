import 'dart:convert';

import 'package:bayapar_retailer/consts/consts.dart';
import 'package:bayapar_retailer/controller/cart_controller.dart';
import 'package:bayapar_retailer/controller/product_controller.dart';
import 'package:bayapar_retailer/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'category/category controller.dart';
import 'controller/order_controller.dart';
import 'controller/retailer_detail_controller.dart';

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(FirebaseController());
  Get.put(CustomersService());
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(OrderController());
  Get.put(CustomersService());
  Get.put(CategoriController());

  runApp(Bayapar());
}

class Bayapar extends StatefulWidget {
  const Bayapar({Key? key}) : super(key: key);

  @override
  _BayaparState createState() => _BayaparState();
}

class _BayaparState extends State<Bayapar> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: _connectionStatus == ConnectivityResult.none
          ? OfflineScreen()
          : SplashScreen(),
    );
  }
}

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'No Internet Connection',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
