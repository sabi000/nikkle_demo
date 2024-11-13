import 'package:flutter/material.dart';
import 'package:nikkle/models/products.dart';
import 'package:nikkle/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  int _selectedIndex = 0;
  String selectedCategory = 'All Categories';
  final List<String> categories = [
    'All Categories',
    'cat 1',
    'cat 2',
    'cat 3',
  ];

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
        currency: 'USD',
        price: 29.99,
        qty: 112,
        unit: 'pc'),
    Product(
        image: 'assets/images/image.png',
        name: 'Bluetooth Headphones',
        currency: 'USD',
        price: 89.99,
        qty: 150,
        unit: 'pc'),
    Product(
        image: 'assets/images/image.png',
        name: 'Smartphone Stand',
        currency: 'USD',
        price: 15.50,
        qty: 5,
        unit: 'kg'),
  ];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
          _buildPageContent(_selectedIndex),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 0.0,
          selectedIconTheme: const IconThemeData(color: TColors.primary),
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          selectedItemColor: TColors.primary,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return dashboard();
      case 1:
        return const Center(child: Text('Cart Page Content'));
      case 2:
        return const Center(child: Text('Settings Page Content'));
      case 3:
        return const Center(child: Text('Profile Page Content'));
      default:
        return dashboard();
    }
  }

  Widget dashboard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: TColors.white)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  dropdownColor: Colors.blue,
                  icon: const Icon(Icons.arrow_drop_down, color: TColors.white),
                ),
              ),
              Row(
                children: [
                  Text('Pos',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: TColors.white)),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context, '/login');
                        },
                        icon: const Icon(
                          Icons.logout_rounded,
                          size: 16,
                        ),
                        label: Text('Logout',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: TColors.primary))),
                  ),
                ],
              )
            ],
          ),
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
              elevation: 4,
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
                        icon: const Icon(Icons.remove),
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
                        icon: const Icon(Icons.add),
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
