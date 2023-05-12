import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';
import '../../category/categories_display.dart';
import '../../category/category controller.dart';
import '../../home_controllers/home_controller.dart';
import '../cart_screen/cart_screen.dart';
import '../profile_screen/myorder/my_order.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final categoryController = Get.find<CategoriController>();

  @override
  void initState() {
    super.initState();
    setState(() {
      categoryController.getCategories();

    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Homecontroller());
    var navbaritem=[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined,size: 25,),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined,size: 25
          ,),
        label: "Cart",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icOrder,height: 20,width: 20,),
        label: "Orders",
      ),


    ];

    var navbody=[
      CategoriesPage(),
      // HomeScreen(),
      CartScreen(),
      MyOrder(),

    ];

    return WillPopScope(
        onWillPop: () async {
      bool exit = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want to exit?'),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
      return exit ?? false;
    },child: Scaffold(
      body: Column(
        children: [
          Obx(()=> Expanded(child: navbody.elementAt(controller.currentNavINdex.value))),
        ],
      ),
      bottomNavigationBar: Obx(
            ()=> BottomNavigationBar(
          currentIndex: controller.currentNavINdex.value,
          selectedItemColor: redColor, // set color of selected item's icon
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          onTap: (value){
            controller.currentNavINdex.value =value;
          },
          items: navbaritem,
        ),
      ),
    ),);
  }
}
