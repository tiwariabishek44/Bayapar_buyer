class RetailerModel {
  final String ownerName;
  final String shopName;
  final String address;
  final String street;
  final String municipality;
  final String phoneNumber;


  RetailerModel({
    required this.ownerName,
    required this.shopName,
    required this.address,
    required this.street,
    required this.municipality,
    required this.phoneNumber,

  });

  Map<String, dynamic> toMap() {
    return {
      'ownerName': ownerName,
      'shopName': shopName,
      'address': address,
      'street': street,
      'municipality' :municipality,
      'phoneNumber': phoneNumber,

    };
  }

  static RetailerModel fromMap(Map<String, dynamic> map) {
    return RetailerModel(
      ownerName: map['ownerName'],
      shopName: map['shopName'],
      address: map['address'],
      street: map['street'],
      municipality: map['municipality'],
      phoneNumber: map['phoneNumber'],


    );
  }
}
