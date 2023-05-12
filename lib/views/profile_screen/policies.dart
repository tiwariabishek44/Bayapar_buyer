import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';

import '../../controller/category_controller.dart';
import '../../models/category_model.dart';



class Policies extends StatelessWidget {
  const Policies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments as String;

    return Scaffold(backgroundColor: whiteColor,
      appBar: AppBar(backgroundColor: whiteColor,
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: darkFontGrey, // set icon color to black
        ),
        title: Text(title, style:
        TextStyle(fontFamily: semibold,color: redColor),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 16.0),
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'We respect your privacy and are committed to protecting your personal information. We will not share your information with third parties without your consent.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
