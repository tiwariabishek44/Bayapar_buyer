import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../homescreen/home.dart';

const String kPhoneNumberKey = 'phone_number';

class MyVerify extends StatefulWidget {
  final String verificationId;

  const MyVerify({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  bool loading = false;
  final smscontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  late final SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _savePhoneNumber(String phoneNumber) async {
    await _prefs.setString(kPhoneNumberKey, phoneNumber);
  }

  String? _getSavedPhoneNumber() {
    return _prefs.getString(kPhoneNumberKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 143,
            decoration: BoxDecoration(
              color: whiteColor,
              image: DecorationImage(
                image: AssetImage(bayapar),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 140),
            decoration: BoxDecoration(
              color: whiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                controller: smscontroller,
                length: 6,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffff2d55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: smscontroller.text.toString(),
                    );
                    try {
                      await auth.signInWithCredential(credential);
                      final phoneNumber = auth.currentUser?.phoneNumber;

                      if (phoneNumber != null) {
                        await _savePhoneNumber(phoneNumber);
                      }
                      if (_prefs != null) {
                        await _prefs!.setString('phone', phoneNumber.toString());
                      }

                      Get.offAll(() => Home());
                    }catch (e) {
                      setState(() {
                        loading = false;
                      });
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text("Invalid OTP"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: loading
                      ? CircularProgressIndicator()
                      : Text(
                    "Verify",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),),
                SizedBox(
                  height: 20,
                ),
                  OTPResendButton(
                    resendOTP:  () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        await auth.verifyPhoneNumber(
                          phoneNumber: _getSavedPhoneNumber()!,
                          verificationCompleted: (credential) async {
                            await auth.signInWithCredential(credential);
                            final phoneNumber = auth.currentUser?.phoneNumber;
                            if (phoneNumber != null) {
                              await _savePhoneNumber(phoneNumber);
                            }
                            Get.offAll(() => Home());
                          },
                          verificationFailed: (error) {
                            setState(() {
                              loading = false;
                            });
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Error"),
                                content: Text(error.message!),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            setState(() {
                              loading = false;
                            });
                            Get.to(() => MyVerify(verificationId: verificationId));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OTPResendButton extends StatefulWidget {
  const OTPResendButton({
    Key? key,
    required this.resendOTP,
  }) : super(key: key);

  final VoidCallback resendOTP;

  @override
  State<OTPResendButton> createState() => _OTPResendButtonState();
}

class _OTPResendButtonState extends State<OTPResendButton> {
  late Timer _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 0;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const interval = const Duration(seconds: 1);
    const seconds = 20;
    _remainingSeconds = seconds;

    _timer = Timer.periodic(interval, (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _remainingSeconds == 0
          ? () {
        widget.resendOTP();
        startTimer();
      }
          : null,
      child: Text(
        _remainingSeconds == 0 ? "Resend OTP" : "Resend in $_remainingSeconds seconds",
        style: TextStyle(
          color: _remainingSeconds == 0 ? Color(0xffff2d55) : Colors.grey,
        ),
      ),
    );
  }
}
