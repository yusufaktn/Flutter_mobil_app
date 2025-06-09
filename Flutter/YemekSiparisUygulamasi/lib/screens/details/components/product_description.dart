// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../models/ProductModel.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isHeart = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.product.NAME,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isHeart = !isHeart;
                  
                });
              },
              child: Icon(
                isHeart ? Icons.favorite : Icons.favorite_border,
                size: 24,
                color: isHeart ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 64),
          child: Text(widget.product.DESCRIPTION),
        ),
      ],
    );
  }
}
