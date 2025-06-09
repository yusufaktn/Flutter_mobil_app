import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/state/ProdactState.dart';

import '../details/details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static String routeName = "/products";

  @override
  Widget build(BuildContext context) {
    final product_state = Provider.of<ProductState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürünler"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            itemCount: product_state.Allproducts.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.7,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => ProductCard(
              product: product_state.Allproducts[index],
              onPress: () => Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: ProductDetailsArguments(product: product_state.Allproducts[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
