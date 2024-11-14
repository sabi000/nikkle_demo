import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            dropdownColor: TColors.primary,
            icon: SvgPicture.asset(
              'assets/icons/dropdown.svg',
            ),
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
          child: SvgPicture.asset(
            'assets/icons/back.svg',
          ),
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
                  icon: SvgPicture.asset(
                    'assets/icons/logout.svg',
                  ),
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

  Widget _buildBottomNavigation() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 0.0,
          selectedItemColor: TColors.primary,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/home_bold.svg',
                colorFilter:
                    const ColorFilter.mode(TColors.primary, BlendMode.srcIn),
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return cartProvider.itemCount.value > 0
                      ? badges.Badge(
                          badgeContent: Text(
                            '${cartProvider.itemCount.value}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/cart.svg',
                          ),
                        )
                      : SvgPicture.asset(
                          'assets/icons/cart.svg',
                        );
                },
              ),
              activeIcon: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return cartProvider.itemCount.value > 0
                      ? badges.Badge(
                          badgeContent: Text(
                            '${cartProvider.itemCount.value}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/cart_bold.svg',
                            colorFilter: const ColorFilter.mode(
                                TColors.primary, BlendMode.srcIn),
                          ),
                        )
                      : SvgPicture.asset(
                          'assets/icons/cart_bold.svg',
                          colorFilter: const ColorFilter.mode(
                              TColors.primary, BlendMode.srcIn),
                        );
                },
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/settings.svg',
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/settings_bold.svg',
                colorFilter:
                    const ColorFilter.mode(TColors.primary, BlendMode.srcIn),
              ),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/profile_bold.svg',
                colorFilter:
                    const ColorFilter.mode(TColors.primary, BlendMode.srcIn),
              ),
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
