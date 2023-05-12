class Category {
  final String name;
  final String rank;
  final List<Item> items;

  Category({
    required this.name,
    required this.rank,
    required this.items,
  });
}

class Item {
  final String name;
  final String image;

  Item({
    required this.name,
    required this.image,
  });
}


class Subcategory {
  final String name;
  final String mainCategory;
  final String subimage;


  Subcategory({
    required this.mainCategory,
    required this.name,
    required this.subimage

  });
}
