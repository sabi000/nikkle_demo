import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nikkle/models/cart_item.dart';
import 'package:nikkle/services/cart_provider.dart';
import 'package:nikkle/utils/colors.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartProvider cartProvider = CartProvider();

  late List<CartItem> cartItem = [];
  final ValueNotifier<int> cartItemCount = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
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
          cart()
        ]),
      ),
    );
  }

  Widget cart() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.only(top: 90, left: 30),
        decoration: BoxDecoration(
          color: TColors.bg,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Card(
          color: TColors.bg,
          elevation: 0.0,
          child: Column(
            children: [
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your Cart - ${cartProvider.itemCount.value} items',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                },
              ),
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return cartProvider.cartItems.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 80,
                                  color: TColors.primary,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Your cart is empty!',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Add items to your cart and enjoy shopping!',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Flexible(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...cartProvider.cartItems.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              item.image,
                                              width: 45,
                                              height: 45,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.remove_circle,
                                                        color: TColors.primary,
                                                      ),
                                                      onPressed: () {
                                                        cartProvider
                                                            .decreaseQuantity(
                                                                item);
                                                      },
                                                    ),
                                                    Text(
                                                      item.selectedqty
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.add_circle,
                                                        color: TColors.primary,
                                                      ),
                                                      onPressed: () {
                                                        cartProvider
                                                            .increaseQuantity(
                                                                item);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 24,
                                              width: 24,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  cartProvider
                                                      .removeItemFromCart(item);
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: TColors.primary),
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              child: Text(
                                                '${item.currency} ${item.price.toStringAsFixed(2)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: TColors.primary,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total -',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        '${cartProvider.cartItems.isNotEmpty ? cartProvider.cartItems[0].currency : ''} ${cartProvider.totalAmount.value.toStringAsFixed(2)}',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: Center(
                                                  child: Text('PROCEED TO PAY',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge),
                                                ),
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                        'Total Item: ${cartProvider.itemCount.value.toString()}'),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                        'Total AmountPrice: ${cartProvider.totalAmount.value.toStringAsFixed(2)}'),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: TColors.bg,
                                      child: SvgPicture.asset(
                                        'assets/icons/checkout.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    label: Text(
                                      'Checkout',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: TColors.white,
                                          ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32.0, vertical: 12.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      backgroundColor: TColors.primary,
                                      foregroundColor: TColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
