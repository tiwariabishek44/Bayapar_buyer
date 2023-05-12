class ProductModel {
  final String image;
  final String name;
  final String subcategory;
  final List<double> priceList;
  final List<double> marginList;
  final List<double> mrpList;
  final List<String> variantList;
  final String supplierName;
  final String supplierPhoneNumber;
  String? description;
  int currentStock;
  int minimumStockAlert;
  int stockInput;
  int totalUnitsSold;
  double revenue;

  ProductModel({
    required this.image,
    required this.name,
    required this.subcategory,
    required this.priceList,
    required this.marginList,
    required this.mrpList,
    required this.variantList,
    required this.supplierName,
    required this.supplierPhoneNumber,
    this.description,
    required this.currentStock,
    required this.minimumStockAlert,
    required this.stockInput,
    required this.totalUnitsSold,
    required this.revenue,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'subcategory':subcategory,
      'priceList': priceList,
      'marginList': marginList,
      'mrpList': mrpList,
      'variantList': variantList,
      'supplierName': supplierName,
      'supplierPhoneNumber': supplierPhoneNumber,
      'description': description,
      'currentStock': currentStock,
      'minimumStockAlert': minimumStockAlert,
      'stockInput': stockInput,
      'totalUnitsSold': totalUnitsSold,
      'revenue': revenue,
    };
  }

  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      image: map['image'],
      name: map['name'],
      subcategory: map['subcategory'],
      priceList: List<double>.from(map['priceList']),
      marginList: List<double>.from(map['marginList']),
      mrpList: List<double>.from(map['mrpList']),
      variantList: List<String>.from(map['variantList']),
      supplierName: map['supplierName'],
      supplierPhoneNumber: map['supplierPhoneNumber'],
      description: map['description'],
      currentStock: map['currentStock'],
      minimumStockAlert: map['minimumStockAlert'],
      stockInput: map['stockInput'],
      totalUnitsSold: map['totalUnitsSold'],
      revenue: map['revenue'],
    );
  }
}
