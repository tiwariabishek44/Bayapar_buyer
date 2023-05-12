import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/consts.dart';

class Stock_low extends StatelessWidget {


  NepaliDateTime _nepaliDate = NepaliDateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
          backgroundColor: whiteColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
            color: darkFontGrey, // set icon color to black
          ),
          elevation: 0.5,
          title: Text("Products", style:
          TextStyle(fontFamily: semibold,color: redColor),),

          actions: [Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('${_nepaliDate.year}-${_nepaliDate.month}-${_nepaliDate.day}', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                color: darkFontGrey),),
          )]
      ),
      body: Padding(
        padding: EdgeInsets.all(9),
        child: SingleChildScrollView(
          child: Column(
              children:List.generate(3, (index) => GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Image.network('https://kwalitynepal.com/wp-content/uploads/2022/02/marie.png',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),14.widthBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Marie "
                                .text
                                .fontFamily(regular).size(18)
                                .color(darkFontGrey)
                                .make(),


                            5.heightBox,
                            Text(
                              'Variant: 30gm',
                              style: TextStyle(fontSize: 16),
                            ),

                          ],
                        ),
                      ],
                    )
                ,25.heightBox,
                    Divider(height: 0.1,thickness: 0.1,color: darkFontGrey,)
                    ,10.heightBox,
                  ],
                ),
              ),)
          ),
        ),
      ),


    );
  }
}

