import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/FavoriteModel.dart';
import 'package:shop_app/models/state/AccountState.dart';
import 'package:shop_app/models/state/FavoriteState.dart';
import 'package:shop_app/services/FavoriteService/favorite_service.dart';

import '../constants.dart';
import '../models/ProductModel.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final user_state = Provider.of<UserState>(context, listen: true);
    final favorite_state = Provider.of<FavoriteState>(context, listen: true);
    bool isHeart = favorite_state.isfavorite(widget.product.LOGICALREF);

    return SizedBox(
      width: widget.width,
      child: InkWell(
        onTap: widget.onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.01,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: widget.product.IMAGE.isNotEmpty && widget.product.IMAGE.isNotEmpty
                            ? Image.asset(widget.product.IMAGE)
                            : Text("Resim Yüklenemedi")),
                    Positioned(
                      right: -8,
                      top: -3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              widget.product.RATING.toString(),
                              style: const TextStyle(
                                fontSize: 12,
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
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.NAME,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.product.PRICE.toDouble()} TL",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () async {
                    if (isHeart == true) {
                      setState(() {
                        isHeart = false;
                      });

                      await FavoriteService().deletefavorite(widget.product.LOGICALREF);
                    } else {
                      setState(() {
                        isHeart = true;
                      });
                      var favorite = Favorite(
                        LOGICALREF: 0,
                        ACCOUNTREF: user_state.logicalref,
                        STOCKCARDREF: widget.product.LOGICALREF,
                        ADDEDDATE: "",
                      );

                      bool success = await FavoriteService().postfavorite(favorite);
                      if (success == false) {
                        setState(() {
                          isHeart = false;
                        });
                      }
                    }
                    await favorite_state.fetch_favorite(user_state.logicalref);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: 24,
                    width: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isHeart ? Icons.favorite : Icons.favorite_border,
                      size: 14,
                      color: isHeart ? Colors.red : Colors.black,
                    ),
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
