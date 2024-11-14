import 'package:flutter/material.dart';
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
        appBar: AppBar(
          backgroundColor: TColors.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: TColors.white,
            ),
          ),
          actions: [
            Row(
              children: [
                Text(
                  'Pos',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: TColors.white),
                ),
                const SizedBox(width: 10),
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
                    label: Text(
                      'Logout',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: TColors.primary),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ],
        ),
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
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: TColors.bg,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Card(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Add items to your cart and enjoy shopping!',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cartProvider.cartItems.length,
                                  itemBuilder: (context, index) {
                                    CartItem item =
                                        cartProvider.cartItems[index];
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
                                                          color:
                                                              TColors.primary,
                                                        ),
                                                        onPressed: () {
                                                          Provider.of<CartProvider>(
                                                                  context,
                                                                  listen: false)
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
                                                          color:
                                                              TColors.primary,
                                                        ),
                                                        onPressed: () {
                                                          Provider.of<CartProvider>(
                                                                  context,
                                                                  listen: false)
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
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeItemFromCart(
                                                            item);
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
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: Text(
                                                  '${item.currency} ${item.price.toStringAsFixed(2)}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          color:
                                                              TColors.primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Column(
                                  children: [
                                    Consumer<CartProvider>(
                                      builder: (context, cartProvider, child) {
                                        return Padding(
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
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                              Text(
                                                  '${cartProvider.cartItems[0].currency} ${cartProvider.totalAmount.value.toString()}'),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          //CHECKOUT LOGIC
                                        },
                                        icon: const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: TColors.bg,
                                          child: Icon(
                                            Icons.shopping_cart_outlined,
                                            color: TColors.primary,
                                            size: 18,
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
                                                horizontal: 32.0,
                                                vertical: 12.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            backgroundColor: TColors.primary,
                                            foregroundColor: TColors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
