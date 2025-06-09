// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/models/state/CartState.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  void _showSideDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.5,
          child: Container(
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                AppBar(
                  title: Text('Bildirimler'),
                  automaticallyImplyLeading: true,
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Bildirim 1'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Bildirim 2'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Bildirim 3'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      },
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 16),
          Consumer<CartState>(
            builder: (context, cartProvider, child) {
              int numOfItems = cartProvider.cart.length;
              return IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                numOfitem: numOfItems,
                press: () => Navigator.pushNamed(context, CartScreen.routeName),
              );
            },
          ),
          const SizedBox(width: 8),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () => _showSideDrawer(context),
          ),
        ],
      ),
    );
  }
}
