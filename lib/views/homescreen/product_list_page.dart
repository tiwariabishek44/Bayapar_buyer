import 'package:bayapar_retailer/consts/consts.dart';
import 'package:bayapar_retailer/models/product_model.dart';
import 'package:get/get.dart';
import '../../controller/product_controller.dart';
import 'cart_screen2.dart';
import 'item_detail.dart';


Widget _buildItemCard(ProductModel product) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey[300]!, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Expanded (
          child: Container(
            height: 150.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              image: DecorationImage(
                image: NetworkImage(product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                'Price: Rs. ${product.priceList.first.toInt()}-${product.priceList.last.toInt()}',
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Text(
                    ' Margin ${product.marginList[0].toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 14.0, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class Product_list extends StatefulWidget {
  final String subcategory;
  final String pagetitle;

  const Product_list({super.key, required this.subcategory, required this.pagetitle});

  @override
  _Product_listState createState() => _Product_listState();
}


class _Product_listState extends State<Product_list> {
  final productController = Get.find<ProductController>();
  late Future<void> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = productController.getProducts(widget.subcategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text("${widget.subcategory}",style: TextStyle(color: darkFontGrey),),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: darkFontGrey, // set icon color to black
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Image.asset(icCart,color: darkFontGrey,),
                onPressed: () {
                  Get.to(CartScreen2(),);
                },
                color: Colors.black, // set icon color to black
              ),
            ],
          ),5.widthBox,
        ],
      ),
      body: FutureBuilder<void>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (productController.products.isEmpty) {
              return  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 48,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text('No products found.'),
                  ],
                ),
              );
            } else {
              return  Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: GridView.builder(
                  itemCount: productController.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return GestureDetector(
                        onTap: (){Get.to(()=>ItemDetails(product: product,));},
                        child: _buildItemCard(product));
                  },
                ),
              );



            }
          }
        },
      ),
    );
  }
}
