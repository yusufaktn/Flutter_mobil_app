import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/state/FavoriteState.dart';

import '../details/details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favorite_state = Provider.of<FavoriteState>(context, listen: true);

    return SafeArea(
      child: Column(
        children: [
          Text(
            "Favoriler",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<FavoriteState>(
                builder: (context, value, child) {
                  return GridView.builder(
                      itemCount: favorite_state.favoriteProduct.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        {
                          return ProductCard(
                            product: favorite_state.favoriteProduct[index],
                            onPress: () => Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: ProductDetailsArguments(
                                  product: favorite_state.favoriteProduct[index]),
                            ),
                          );
                        }
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
