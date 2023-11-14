class Item {
  String name, description;
  int itemId;
  double price;

  Item(
      {required this.name,
      required this.itemId,
      this.price = 0.0,
      this.description = ''});

  factory Item.fromJson(Map<String, dynamic> map) => Item(
        name: map['name'],
        itemId: map['itemId'],
        description: map['description'],
        price: map['price'],
      );

  Map<String, dynamic> toMap() => {
        'itemId': itemId,
        'name': name,
        'price': price,
        'description': description,
      };
}
