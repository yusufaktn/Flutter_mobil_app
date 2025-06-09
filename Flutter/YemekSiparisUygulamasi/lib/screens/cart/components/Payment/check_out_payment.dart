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

class CheckoutPayment extends StatefulWidget {
  const CheckoutPayment(
      {Key? key, required this.cartList, required this.odeme, required this.select})
      : super(key: key);
  final String odeme;
  final List<Cart> cartList;
  final int select;

  @override
  State<CheckoutPayment> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutPayment> {
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
    final user_state = Provider.of<UserState>(context, listen: true);
    final cartState = Provider.of<CartState>(context, listen: true);
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
                  child: Text.rich(
                    TextSpan(
                      text: "Toplam:\n",
                      children: [
                        TextSpan(
                          text: "${cartState.total_toplam.toStringAsFixed(2)}TL\n",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: widget.odeme,
                          style: const TextStyle(
                            fontSize: 10,
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
                      DateTime now = DateTime.now();

                      var order = Order(
                          LOGICALREF: 0,
                          ACCOUNTREF: user_state.logicalref,
                          PAYMENTREF: widget.select.toString(),
                          ORDER_DATE_TIME: now.toIso8601String(),
                          ORDER_TOTAL_PRICE: cartState.total_toplam.toString(),
                          SHIP_ADDRESS: user_state.selectedAddress.toString(),
                          ORDER_STATUS: "1");
                      if (widget.select > 0) {
                        int orderLogicalref = await OrderService().orderpost(order);

                        for (var cart in widget.cartList) {
                          var orderdetail = OrderDetails(
                              STOCK_NAME: "",
                              LOGICALREF: 0,
                              ORDERREF: orderLogicalref,
                              STOCKCARDREF: cart.product.LOGICALREF,
                              AMOUNT: cart.numOfItem);
                          await OrderService().orderDetailpost(orderdetail);

                          Navigator.pushNamed(context, InitScreen.routeName);
                        }
                      }
                    },
                    child: const Text("Siparişi Onayla"),
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
