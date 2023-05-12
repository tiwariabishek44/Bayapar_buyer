import 'package:bayapar_retailer/consts/consts.dart';
Widget homeButtons({width, height, icon, String? title, onpress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 26,),
        10.heightBox,
        Text(title!, style: TextStyle(fontFamily: semibold, color: darkFontGrey),)

      ],
  ).box.rounded.white.size(width, height).make().onTap(() { });
}