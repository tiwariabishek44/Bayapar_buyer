import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';

class Contact_us extends StatelessWidget {
  const Contact_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments as String;

    return Scaffold(backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: darkFontGrey,
        ),
        title: Text(
          title,
          style: TextStyle(fontFamily: semibold, color: redColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'If you have any questions or feedback, please don\'t hesitate to contact us at:',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '9742555741',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
