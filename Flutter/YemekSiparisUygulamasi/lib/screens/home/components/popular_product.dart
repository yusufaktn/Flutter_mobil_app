import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/state/ProdactState.dart';

import '../../../components/product_card.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final product_state = Provider.of<ProductState>(context, listen: true);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popüler Ürünler",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                product_state.Allproducts.length,
                (index) {
                  if (product_state.Allproducts[index].ISPOPULAR) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ProductCard(
                        product: product_state.Allproducts[index],
                        onPress: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments:
                              ProductDetailsArguments(product: product_state.Allproducts[index]),
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink(); // here by default width and height is 0
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}
