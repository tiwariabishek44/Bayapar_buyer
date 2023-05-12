import 'package:bayapar_retailer/consts/consts.dart';

import 'cart.dart';

class Orders {
      String? id;
  late final String buyerPhone;
  late final String supplierName;
  late final String sellerPhone;

  late final String retailerShopName; // new field to identify retailer shop
  late final List<CartItem> cartItems;
  late final String municipality;
  late final String street;
  late final String address;
  late final double totalPrice;
  late final String orderDate;
  late final String paymentMethod;
  late final bool isConfirmed;
  late final bool isPackaging;
  late final bool isOnRoad;
  late final bool isDiscount;

      late final String time;
  late final double discount;
  late final  double unitQuantity;
  late final String unitType;

  Orders({
    this.id,
    required this.buyerPhone,
    required this.supplierName,
    required this.sellerPhone,
      required this.retailerShopName,
    required this.cartItems,
    required this.municipality,
    required this.street,
    required this.address,
    required this.totalPrice,
    required this.orderDate,
    required this.paymentMethod,
    required this.isConfirmed,
    required this.isPackaging,
    required this.isOnRoad,
    required this.isDiscount,
    required this.time,
    required this.discount,
    required this.unitQuantity,
    required this.unitType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerPhone': buyerPhone,
      'supplierName': supplierName,
      'sellerPhone': sellerPhone,
      'retailerShopName': retailerShopName,
      'cartItems': cartItems.map((item) => item.toMap()).toList(),
      'municipality': municipality,
      'street': street,
      'address': address,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'isConfirmed': isConfirmed,
      'isPackaging': isPackaging,
      'isOnRoad': isOnRoad,
      'isDiscount':isDiscount,
      'time':time,
      'discount':discount,
      'unitQuantity':unitQuantity,
      'unitType' :unitType,

    };
  }

  static Orders fromMap(Map<String, dynamic> map,) {
    return Orders(
      id: map['id'],
      buyerPhone: map['buyerPhone'],
      supplierName: map['supplierName'],
      sellerPhone: map['sellerPhone'],
      retailerShopName: map['retailerShopName'],
      cartItems: List<CartItem>.from(
        map['cartItems'].map((item) => CartItem.fromMap(item)),
      ),
      municipality: map['municipality'],
      street: map['street'],
      address: map['address'],
      totalPrice: map['totalPrice'].toDouble(),
      orderDate: map['orderDate'],
      paymentMethod: map['paymentMethod'],
      isConfirmed: map['isConfirmed'],
      isPackaging: map['isPackaging'],
      isOnRoad: map['isOnRoad'],
      isDiscount: map['isDiscount'],
      time:map['time'],
      discount: map['discount'],
      unitQuantity: map['unitQuantity'],
      unitType: map['unitType']
    );
  }
}
