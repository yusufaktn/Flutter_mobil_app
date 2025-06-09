import 'ProductModel.dart';

class Cart {
  final Product product;
  int numOfItem;
  double total;

  Cart({required this.product, required this.numOfItem, required this.total});

  void adet_azalt() {
    numOfItem--;
  }

  void update_total() {
    total = product.PRICE * numOfItem;
  }
 /* void update_tplam() {
    total_toplam += total;
  }*/
}
//List<Cart> demoCarts = [];
