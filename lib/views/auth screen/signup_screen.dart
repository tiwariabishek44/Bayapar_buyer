import 'package:bayapar_retailer/views/auth%20screen/login_screen.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../widget/applogo_widgit.dart';
import '../../widget/bg_widget.dart';
import '../../widget/costom_textfild.dart';
import '../../widget/our_button.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? ischeck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteColor,
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
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Sign up with bapayar",style: TextStyle(
                          color: darkFontGrey, fontFamily: semibold, fontSize: 18
                      ),),
                    ),
                  ),
                  5.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextField2(
                      title: "Pone No",
                      icon: Icon(Icons.mail),

                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        autofocus: false,
                        obscureText: false,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),

                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),

                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            labelStyle: TextStyle(
                                fontSize: 15
                            )
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        value: ischeck, onChanged: (newval){
                        setState(() {
                          ischeck = newval;
                        });
                      },
                        checkColor: whiteColor,),
                      10.widthBox,
                      Expanded(
                        child: RichText(text: const TextSpan(
                            children:[
                              TextSpan(
                                  text: "Iagree to the ",
                                  style: TextStyle(fontFamily: regular, color: fontGrey)
                              ),
                              TextSpan(
                                  text: termAndCond,
                                  style: TextStyle(fontFamily: regular, color: redColor)
                              ),
                              TextSpan(
                                  text: " & ",
                                  style: TextStyle(fontFamily: regular, color: fontGrey)
                              ),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(fontFamily: regular, color: fontGrey)
                              )



                            ]
                        )),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: (){
                      },//since this is only a UI app
                      child: Text('Register',
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

                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: RichText(
                          text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "Already have an account?",
                                    style: TextStyle(
                                      fontFamily: 'SFUIDisplay',
                                      color: Colors.black,
                                      fontSize: 15,
                                    )
                                ),

                                TextSpan(
                                    text: " log in",
                                    style: TextStyle( fontWeight: FontWeight.bold,
                                      fontFamily: 'SFUIDisplay',
                                      color: Color(0xffff2d55),
                                      fontSize: 17,
                                    )
                                )
                              ]
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
