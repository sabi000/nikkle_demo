class CartItem {
  final String image;
  final String name;
  final String currency;
  final double price;
  final int selectedqty;
  CartItem({
    required this.image,
    required this.name,
    required this.currency,
    required this.price,
    required this.selectedqty,
  });

  @override
  String toString() {
    return 'CartItem(image: $image, name: $name, currency: $currency, price: $price, selectedqty: $selectedqty)';
  }
}
