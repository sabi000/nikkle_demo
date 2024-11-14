import 'dart:convert';

class CartItem {
  final String image;
  final String name;
  final String currency;
  final double price;
  final int totalqty;
  int selectedqty;

  CartItem({
    required this.image,
    required this.name,
    required this.currency,
    required this.price,
    required this.totalqty,
    required this.selectedqty,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'currency': currency,
      'price': price,
      'totalqty': totalqty,
      'selectedqty': selectedqty,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      image: map['image'] as String,
      name: map['name'] as String,
      currency: map['currency'] as String,
      price: map['price'] as double,
      totalqty: map['totalqty'] as int,
      selectedqty: map['selectedqty'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
