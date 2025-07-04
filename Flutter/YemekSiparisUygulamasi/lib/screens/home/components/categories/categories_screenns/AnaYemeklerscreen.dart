import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/ProductModel.dart';
import 'package:shop_app/models/state/ProdactState.dart';
import 'package:shop_app/screens/details/details_screen.dart';

class AnaYemekScreen extends StatelessWidget {
  static String routaName = "/anayemekler";
  const AnaYemekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product_state = Provider.of<ProductState>(context, listen: false);
    final List<Product> filterProduct =
        product_state.Allproducts.where((element) => element.CATEGORYREF == 3).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Ana Yemekler"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                      itemCount: filterProduct.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        {
                          return ProductCard(
                            product: filterProduct[index],
                            onPress: () => Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: ProductDetailsArguments(product: filterProduct[index]),
                            ),
                          );
                        }
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
