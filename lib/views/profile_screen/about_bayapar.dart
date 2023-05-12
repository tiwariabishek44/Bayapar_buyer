import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments as String;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: Colors.grey[800],
        ),
        title: Text(
          title,
          style: TextStyle(fontFamily: 'Roboto', color: Colors.red[900], fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Founded in 2078 with a vision to "transform the way trade is done in Nepal leveraging technology", bayapar is Nepal’s largest business-to-business e-commerce platform. It has operations across categories including lifestyle, electronics, home & kitchen, staples, FMCG, toys and general merchandise.',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[800], fontFamily: 'Roboto'),
              ),
              SizedBox(height: 24.0),
              Text(
                'Mission',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'bayapar is solving core trade problems faced by small and medium businesses, that are unique to Nepal, through its unique Nepal-fit low-cost business model by leveraging technology and bringing the benefits of eCommerce to them. It is a one-stop shop for all business requirements in the B2B space. bayapar has built inclusive tech tools for Nepal, specially catering to the needs of brands, retailers, and manufacturers, providing them a level playing field to scale, trade, and grow businesses.',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[800], fontFamily: 'Roboto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
