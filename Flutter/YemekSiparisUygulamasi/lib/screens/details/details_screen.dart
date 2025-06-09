import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

import '../../models/ProductModel.dart';
import '../../models/state/CartState.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isStar1 = false;
  bool isStar2 = false;
  bool isStar3 = false;
  bool isStar4 = false;
  bool isStar5 = false;

  void reset_star() {
    setState(() {
      isStar1 = false;
      isStar2 = false;
      isStar3 = false;
      isStar4 = false;
      isStar5 = false;
    });
  }

  void _addToCart(BuildContext context, Product product, int quantity) {
    final cartState = Provider.of<CartState>(context, listen: false);

    bool found = false;

    for (var item in cartState.cart) {
      if (item.product == product) {
        item.numOfItem += quantity;
        item.total += product.PRICE * quantity;
        cartState.update_tplam();
        found = true;
        break;
      }
    }

    if (!found) {
      cartState.cart.add(Cart(
        product: product,
        numOfItem: quantity,
        total: product.PRICE * quantity,
      ));
      cartState.update_tplam();
    }

    _showAddConfirmationDialog(context);
  }

  void _removeFromCart(BuildContext context, Product product) {
    final cartState = Provider.of<CartState>(context, listen: false);
    final cartItem = cartState.cart.firstWhere(
      (item) => item.product == product,
      orElse: () => Cart(
        product: product,
        numOfItem: 0,
        total: product.PRICE,
      ),
    );

    if (cartItem.numOfItem > 0) {
      cartItem.adet_azalt();
      cartState.update_tplam();
    }

    if (cartItem.numOfItem == 0) {
      cartState.cart.remove(cartItem);
      cartState.update_tplam();
    }
  }

  int sayi = 1;

  void add() {
    setState(() {
      sayi++;
    });
  }

  void remove() {
    setState(() {
      sayi--;
      if (sayi <= 0) sayi = 1;
    });
  }

  void _showAddConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Ürün Sepete Eklendi"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, CartScreen.routeName);
                    sayi = 1;
                  },
                  child: const Text(
                    "Sepete Git",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    sayi = 1;
                  },
                  child: const Text(
                    "Kapat",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    final product = args.product;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        product.RATING.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset("assets/icons/Star Icon.svg"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  "Detaylar",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text(product.EXTRAINFO),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Kapat"),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                        child: const Text("Daha Fazla"),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Adet:"),
                    Text(
                      sayi.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      color: kPrimaryColor,
                      onPressed: () {
                        add();
                      },
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      color: kPrimaryColor,
                      onPressed: () {
                        remove();
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (sayi > 0) {
                    product.miktar = sayi;
                    _addToCart(context, product, sayi);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Sepete Ekle",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Sepete Git",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
