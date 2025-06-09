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
import 'package:shop_app/screens/cart/components/Payment/payment_screen.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/services/OrderService/order_service.dart';

class AddressCheck extends StatefulWidget {
  const AddressCheck({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressCheck> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<AddressCheck> {
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
    final userState = Provider.of<UserState>(context, listen: false);
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
            /*Row(
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
            ),*/
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, PaymentScreen.routaName);
                    },
                    child: const Text("Devam Et"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
