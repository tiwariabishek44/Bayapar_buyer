class Categories {
  final String image;
  final String name;
  final String range;


  Categories({
    required this.image,
    required this.name,
    required this.range,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'range' : range,
    };
  }

  static Categories fromMap(Map<String, dynamic> map) {
    return Categories(
        image: map['image'],
        name: map['name'],
        range:  map['range']
    );
  }
}
