// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/models/OrderDetailsModel.dart';
import 'package:shop_app/models/OrderModel.dart';
import 'package:shop_app/models/state/AccountState.dart';
import 'package:shop_app/models/state/CartState.dart';
import 'package:shop_app/screens/cart/components/AddressCart/addresscart.dart';
import 'package:shop_app/screens/cart/components/Payment/payment_screen.dart';
import 'package:shop_app/services/OrderService/order_service.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({Key? key, required this.cartList}) : super(key: key);

  final List<Cart> cartList;

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  double t_toplam = 0.0;

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  void calculateTotal() {
    final cartState = Provider.of<CartState>(context, listen: false);
    for (var cart in cartState.cart) {
      setState(() {
        t_toplam += cart.total;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context, listen: true);
    final userState = Provider.of<UserState>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                /*Container(
                  padding: const EdgeInsets.all(10),
                  height: 35,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),*/
                /*const Spacer(),
                  const Text("Kupon Kodu Ekle"),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                ),*/
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Toplam:\n",
                      children: [
                        TextSpan(
                          text: "${cartState.total_toplam.toStringAsFixed(2)} TL",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (cartState.cart.length > 0) {
                        //Navigator.pushNamed(context, PaymentScreen.routaName);
                        Navigator.pushNamed(context, AddressCart.routaName);
                        userState.fetch_address();
                      } else {
                        errorAlert(context);
                      }
                    },
                    child: const Text("Ödeme"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> errorAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          actions: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      Text(
                        "Lütfen Ürün Ekleyin",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  )),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
