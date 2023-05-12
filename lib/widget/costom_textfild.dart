import 'package:bayapar_retailer/consts/consts.dart';

Widget customTextField({
  String? title, String? hint, controller
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title!.text.color(redColor).fontFamily (semibold).size(16).make(),
        5.heightBox,  TextFormField(
          decoration:  InputDecoration(
            hintStyle: TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ), // TextStyle
            hintText: "  $hint" ,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            focusedBorder: OutlineInputBorder (borderSide: BorderSide(color: redColor)
            ), // TextFormField
          ),),

        5.heightBox]
  ); // Column
}


Widget customTextField2({
  String? title,Icon? icon, String? hint, controller
}) {
  return Container(
    color: Color(0xfff5f5f5),
    child: TextFormField(
      autofocus: false
      ,
      controller: controller,
      style: TextStyle(
          color: Colors.red,
          fontFamily: 'SFUIDisplay'
      ),
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        labelText: title,
        prefixIcon: icon,
        labelStyle: TextStyle(fontSize: 15, color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),


      ),
    ),
  );}