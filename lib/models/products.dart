class Product {
  final String image;
  final String name;
  final String currency;
  final double price;
  final int qty;
  final String unit;

  Product({
    required this.image,
    required this.name,
    required this.currency,
    required this.price,
    required this.qty,
    required this.unit,
  });

  @override
  String toString() {
    return 'Product(image: $image, name: $name, currency: $currency, price: $price, qty: $qty, unit: $unit)';
  }
}
