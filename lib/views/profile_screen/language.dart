import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

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
      body: Center(
        child: Text("MYorder"),
      ),
    );
  }
}
