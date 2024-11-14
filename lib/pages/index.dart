import 'package:flutter/material.dart';
import 'package:nikkle/pages/checkout.dart';
import 'package:nikkle/pages/home.dart';
import 'package:nikkle/services/cart_provider.dart';
import 'package:nikkle/services/cart_service.dart';
import 'package:nikkle/utils/colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartService cartService = CartService();

  int _selectedIndex = 0;

  String selectedCategory = 'All Categories';
  final List<String> categories = [
    'All Categories',
    'cat 1',
    'cat 2',
    'cat 3',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget _buildAppBar() {
    Widget leadingWidget;
    final TextStyle labelStyle =
        Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.white);

    switch (_selectedIndex) {
      case 0:
        leadingWidget = DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedCategory,
            items: categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category, style: labelStyle),
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
        );
        break;
      default:
        leadingWidget = GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          child: const Icon(Icons.arrow_back_sharp, color: TColors.white),
        );
        break;
    }

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: TColors.primary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leadingWidget,
          Row(
            children: [
              Text('Pos', style: labelStyle),
              const SizedBox(width: 10),
              SizedBox(
                height: 30,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context, '/login');
                  },
                  icon: const Icon(Icons.logout_rounded, size: 16),
                  label: Text(
                    'Logout',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: TColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
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
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigation() {
    return BottomNavigationBar(
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
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return cartProvider.itemCount.value > 0
                  ? badges.Badge(
                      badgeContent: Text(
                        '${cartProvider.itemCount.value}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      child: const Icon(Icons.shopping_cart_outlined),
                    )
                  : const Icon(Icons.shopping_cart_outlined);
            },
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return const DashboardPage();
      case 1:
        return const CartScreen();
      case 2:
        return const Center(child: Text('Settings Page Content'));
      case 3:
        return const Center(child: Text('Profile Page Content'));
      default:
        return const DashboardPage();
    }
  }
}
