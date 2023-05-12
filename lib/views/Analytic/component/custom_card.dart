import 'package:bayapar_retailer/consts/consts.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final String amount;
  final Color cartcolor;
  final Color textcolor;

  CustomCard({required this.textcolor,required this.text, required this.amount, required this.cartcolor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cartcolor,
      child: Padding(
        padding: EdgeInsets.all(9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(color:textcolor,
                fontSize: 19.0,
                fontFamily: semibold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              amount,
              style: TextStyle(fontSize: 18.0,fontFamily: semibold, color: textcolor),
            ),
          ],
        ),
      ),
    );
  }
}