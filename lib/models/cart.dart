class CartItem {
  String? id;
  String productname;
  double price;
  String buyerShopName;
  String buyerPhoneNumber;
  int quantity;
  String imageUrl;
  String variant;
  String supplierName;
  String sellerPhone;

  CartItem({
    this.id,
    required this.productname,
    required this.price,
    required this.buyerShopName,
    required this.buyerPhoneNumber,
    required this.quantity,
    required this.imageUrl,
    required this.variant,
    required this.supplierName,
    required this.sellerPhone,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productname: map['productname'],
      price: map['price'] ?? 0,
      buyerShopName: map['buyerShopName'],
      buyerPhoneNumber: map['buyerPhoneNumber'],
      quantity: map['quantity'] ?? 0,
      imageUrl: map['imageUrl'],
      variant: map['variant'],
      supplierName: map['supplierName'],
      sellerPhone: map['sellerPhone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productname': productname,
      'price': price,
      'buyerShopName': buyerShopName,
      'buyerPhoneNumber': buyerPhoneNumber,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'variant': variant,
      'supplierName': supplierName,
      'sellerPhone': sellerPhone,
    };
  }
}
