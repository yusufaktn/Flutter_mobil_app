import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/state/CartState.dart';
import 'package:shop_app/screens/cart/components/Payment/check_out_payment.dart';

class PaymentScreen extends StatefulWidget {
  static String routaName = "/payment";
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  int select = 0;
  String payment = "";

  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    double height = 90;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: Container(
                  height: height,
                  width: width,
                  decoration: gradient(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSelected1 = !isSelected1;
                                      isSelected2 = false;
                                      isSelected3 = false;
                                      select = 1;
                                      if (select == 1) {
                                        payment = "KREDİ KARTI";
                                      }
                                    });
                                  },
                                  icon: Icon(isSelected1
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off)),
                              const Text(
                                "KREDİ KARTI",
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/ödemeyöntemi-Photoroom.png",
                            width: 100,
                            height: 90,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              sizedBox(),
              Card(
                child: Container(
                  height: height,
                  width: width,
                  decoration: gradient(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSelected2 = !isSelected2;
                                      isSelected1 = false;
                                      isSelected3 = false;
                                      select = 2;
                                      if (select == 2) {
                                        payment = "NAKİT/KAPIDA ÖDEME";
                                      }
                                    });
                                  },
                                  icon: Icon(isSelected2
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off)),
                              Text("NAKİT / KAPIDA ÖDEME"),
                            ],
                          ),
                          Image.asset(
                            "assets/images/nakitödeme-Photoroom.png",
                            width: 100,
                            height: 80,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              sizedBox(),
              Card(
                child: Container(
                  width: width,
                  height: height,
                  decoration: gradient(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSelected3 = !isSelected3;
                                      isSelected1 = false;
                                      isSelected2 = false;
                                      select = 3;
                                      if (select == 3) {
                                        payment = "SETCARD";
                                      }
                                    });
                                  },
                                  icon: Icon(isSelected3
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off)),
                              Text("SETCARD"),
                            ],
                          ),
                          Image.asset(
                            "assets/images/setcard-Photoroom.png",
                            width: 100,
                            height: 90,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CheckoutPayment(
        select: select,
        odeme: payment,
        cartList: cartState.cart,
      ),
    );
  }

  BoxDecoration gradient() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: const LinearGradient(
            colors: [kPrimaryColor, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight));
  }

  SizedBox sizedBox() {
    return const SizedBox(
      height: 20,
    );
  }
}
