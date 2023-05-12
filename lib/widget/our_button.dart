import "package:bayapar_retailer/consts/consts.dart";

Widget ourbutton({
  onpressed,
  color,
  textcolor,
  String? title
}) {
  return SizedBox(
    height: 45,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12), // Increase vertical padding
      ),
      onPressed: onpressed,
      child: title?.text.color(textcolor).fontFamily(bold).make(),
    ),
  );
}
