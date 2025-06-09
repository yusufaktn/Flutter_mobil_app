// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/ProductModel.dart'; // Varsa, kullanılabilir
import 'package:shop_app/models/state/CartState.dart';
import 'package:shop_app/models/state/ProdactState.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../../../constants.dart';
import '../../../models/CartModel.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          leading: SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: widget.cart.product.IMAGE.isNotEmpty
                    ? Image.asset(
                        widget.cart.product.IMAGE,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/default_image.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          title: Text(
            // ignore: unnecessary_null_comparison
            widget.cart.product != null ? widget.cart.product.NAME : 'Ürün bulunamadı',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      cartState.adet_arttir(widget.cart);
                      cartState.update_total(widget.cart);
                      cartState.update_tplam();
                    },
                  ),
                  Text(
                    widget.cart.numOfItem.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      cartState.adet_azalt(widget.cart);
                      if (widget.cart.numOfItem < 1) {
                        widget.cart.numOfItem = 1;
                      }
                      cartState.update_total(widget.cart);
                      cartState.update_tplam();
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.cart.total.toStringAsFixed(2) + " TL",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
