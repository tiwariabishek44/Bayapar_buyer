import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'phone_no_verification.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final phonenocontroller =TextEditingController();
  final auth = FirebaseAuth.instance;
  late SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          20.heightBox,
          Container(height: 143,
            decoration: BoxDecoration(color: whiteColor,
                image: DecorationImage(
                    image: AssetImage(bayapar,),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter
                )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top:140),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView(physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  15.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Log In to Bayapar B2B wholesale market",style: TextStyle(
                          color: darkFontGrey, fontFamily: semibold, fontSize: 18
                      ),),
                    ),
                  ),
                  15.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        controller: phonenocontroller,
                        style: TextStyle(
                            color: darkFontGrey,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "phone no.",
                          prefixIcon: Icon(Icons.phone),
                          labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),


                        ),
                      ),
                    )
                  ),

                  40.heightBox,
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        auth.verifyPhoneNumber(
                          phoneNumber: "+977" + phonenocontroller.text,
                          verificationCompleted: (_) {
                            setState(() {
                              loading = false;
                            });
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            setState(() {
                              loading = false;
                            });

                            Get.defaultDialog(
                              title: 'Verification Failed',
                              content: Text(e.toString()),
                              confirm: TextButton(
                                onPressed: () => Get.back(),
                                child: Text('OK'),
                              ),
                            );
                          },
                          codeSent: (String verificationId, int? token) async {

                            Get.to(() => MyVerify(
                              verificationId: verificationId,
                            ));
                            setState(() {
                              loading = false;
                            });
                          },
                          codeAutoRetrievalTimeout: (e) {
                            setState(() {
                              loading = false;
                            });
                            Get.defaultDialog(
                              title: 'Verification Timeout',
                              content: Text(
                                'We were unable to verify your phone number within the allotted time. Please check your network connection and try again. If the problem persists, please contact our support team.',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              confirm: TextButton(
                                onPressed: () => Get.back(),
                                child: Text('OK', style: TextStyle(fontSize: 18.0)),
                              ),
                            );
                          },
                        );
                      },
//since this is only a UI app
                      child: loading
                          ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
