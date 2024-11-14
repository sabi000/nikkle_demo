import 'package:flutter/material.dart';
import 'package:nikkle/models/cart_item.dart';
import 'package:nikkle/models/products.dart';
import 'package:nikkle/services/cart_provider.dart';
import 'package:nikkle/services/cart_service.dart';
import 'package:nikkle/utils/colors.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final CartService cartService = CartService();

  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  final List<CartItem> cartItem = [];

  final List<Product> products = [
    Product(
        image: 'assets/images/image.png',
        name: 'UserAdmin',
        currency: 'INR',
        price: 100.00,
        qty: 111,
        unit: 'kg'),
    Product(
        image: 'assets/images/image.png',
        name: 'UserAdmin',
        currency: 'INR',
        price: 100.00,
        qty: 181,
        unit: 'kg'),
    Product(
        image: 'assets/images/image.png',
        name: 'Wireless Mouse',
        currency: 'INR',
        price: 29.99,
        qty: 112,
        unit: 'pc'),
    Product(
        image: 'assets/images/image.png',
        name: 'Bluetooth Headphones',
        currency: 'INR',
        price: 89.99,
        qty: 150,
        unit: 'pc'),
    Product(
        image: 'assets/images/image.png',
        name: 'Smartphone Stand',
        currency: 'INR',
        price: 15.50,
        qty: 5,
        unit: 'kg'),
  ];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.loadCart();
    });

    filteredProducts = products;

    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
        filteredProducts = products.where((product) {
          return product.name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: TColors.primary,
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: TColors.white,
                ),
              ),
            ],
          ),
          dashboard()
        ]),
      ),
    );
  }

  Widget dashboard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                contentPadding: const EdgeInsets.all(10),
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14159),
                  child: const Icon(Icons.search, color: Colors.grey),
                ),
                hintText: 'Search Product',
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
            child: Card(
              color: TColors.bg,
              child: ListView.builder(
                itemCount: filteredProducts.length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return SizedBox(
                    height: 80,
                    child: Center(
                      child: ListTile(
                          leading: Image.asset(
                            product.image,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 80,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: TColors.green,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  '${product.currency} ${product.price.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: TColors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 55,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: TColors.primary,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  '${product.qty.toString()}${product.unit}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: TColors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            addDialog(context, product);
                          }),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> addDialog(BuildContext context, Product product) {
    int qty = 1;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(
                child: Text('Add To Cart',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Name: ${product.name}'),
                  const SizedBox(height: 10),
                  Text(
                      'Price: ${product.currency} ${product.price.toStringAsFixed(2)}'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: TColors.primary,
                        ),
                        onPressed: qty > 0
                            ? () {
                                setState(() {
                                  qty--;
                                });
                              }
                            : null,
                      ),
                      Text(
                        '$qty',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: TColors.primary,
                        ),
                        onPressed: qty < product.qty
                            ? () {
                                setState(() {
                                  qty++;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItemToCart(CartItem(
                            image: product.image,
                            name: product.name,
                            currency: product.currency,
                            price: product.price,
                            selectedqty: qty,
                            totalqty: product.qty));

                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
