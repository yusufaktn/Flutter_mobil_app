// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/state/CartState.dart';
import '../../models/CartModel.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _showDeleteConfirmationDialog() {
    final cartState = Provider.of<CartState>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sepeti Sil"),
          content: const Text("Sepeti silmek istediğinizden emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialogu kapat
              },
              child: const Text("Hayır"),
            ),
            TextButton(
              onPressed: () {
                cartState.clears(); // Sepeti temizle

                Navigator.of(context).pop(); // Dialogu kapat
              },
              child: const Text("Evet"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              children: [
                const Text(
                  "Eklediğiniz Ürünler",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "${cartState.cart.length} ürün",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              color: kPrimaryColor,
              onPressed: _showDeleteConfirmationDialog,
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: cartState.cart.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(cartState.cart[index].product.LOGICALREF.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                cartState.clear2(index);
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(cart: cartState.cart[index]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CheckoutCard(
          cartList: cartState.cart), // cartList parametresi burada geçiriliyor
    );
  }
}
