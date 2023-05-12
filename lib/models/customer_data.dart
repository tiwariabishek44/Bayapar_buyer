class Customer {
  final String? id;
  late final String name;
  late final String phoneNumber;
  late final String retailerPhoneNumber; // new field to identify retailer shop
  List<Transactio> transactions;
  int credit;

  Customer({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.retailerPhoneNumber,
    this.transactions = const [],
    this.credit = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'retailerPhoneNumber': retailerPhoneNumber, // include retailer shop name in map
      'transactions': transactions.map((t) => t.toMap()).toList(),
      'credit': credit,
    };
  }

  static Customer fromMap(Map<String, dynamic> map, ) {
    return Customer(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      retailerPhoneNumber: map['retailerPhoneNumber'], // get retailer shop name from map
      transactions: List<Transactio>.from(
        map['transactions']?.map((t) => Transactio.fromMap(t)) ?? [],
      ),
      credit: map['credit'] ?? 0,
    );
  }
}


class Transactio {
  final String? id;
   final String type;
  final int amount;
  final String date;

  Transactio({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount,
      'date': date,
    };
  }

  static Transactio fromMap(Map<String, dynamic> map) {
    return Transactio(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      date: map['date'],
    );
  }
}
