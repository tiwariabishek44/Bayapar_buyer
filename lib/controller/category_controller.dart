import 'package:cloud_firestore/cloud_firestore.dart';

import '../consts/consts.dart';
import '../models/category_model.dart';

class CategoryController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> getCategories() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore.collection('Category').get();
    return querySnapshot.docs.map((doc) {
      final List<Item> items = List<Item>.from(
        (doc['items'] as List).map(
              (item) => Item(
            name: item['name'] as String,
            image: item['image'] as String,
          ),
        ),
      );
      return Category(name: doc['name'] as String,
          items: items,
        rank :doc['rank'] as String,
      );
    }).toList();
  }

  Future<void> addCategory(Category category) async {
    await _firestore.collection('Category').add({
      'name': category.name,
      'rank' : category.rank,
      'items': category.items
          .map((item) => {'name': item.name, 'image': item.image,})
          .toList(),
    });
  }
}
class SubcategoryController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Subcategory>> getSubcategories(String mainCategory) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore
        .collection('Subcategory')
        .where('mainCategory', isEqualTo: mainCategory)
        .get();
    return querySnapshot.docs.map((doc) {
      return Subcategory(
        name: doc['name'] as String,
        mainCategory: doc['mainCategory'] as String,
        subimage: doc['subimage'] as String,
      );
    }).toList();
  }

  Future<void> addSubcategory(Subcategory subcategory) async {
    await _firestore.collection('Subcategory').add({
      'name': subcategory.name,
      'mainCategory': subcategory.mainCategory,
      'subimage': subcategory.subimage,
    });
  }
}



class AddSubcategoryPage extends StatefulWidget {
  const AddSubcategoryPage({Key? key}) : super(key: key);

  @override
  _AddSubcategoryPageState createState() => _AddSubcategoryPageState();
}

class _AddSubcategoryPageState extends State<AddSubcategoryPage> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SubcategoryController subcategoryController = SubcategoryController();
  void _submitForm() async {
    final subcategory = Subcategory(
      name:'product',
      mainCategory: 'product',
      subimage: 'product',
    );
    await subcategoryController.addSubcategory(subcategory);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Subcategory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [



              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Subcategory'),
              ),
            ],
          ),
        ),
      ),
    );
  }}
