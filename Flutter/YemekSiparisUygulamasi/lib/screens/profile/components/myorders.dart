import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/state/CartState.dart';
import 'package:shop_app/models/state/OrderDetailsState.dart';
import 'package:shop_app/models/state/OrderState.dart';
import 'package:shop_app/models/state/ProdactState.dart';
import 'package:shop_app/screens/profile/components/myordersscreen.dart';

class MyOrders extends StatelessWidget {
  static String routaName = "/myorders";
  const MyOrders({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context, listen: true);
    final product_State = Provider.of<ProductState>(context, listen: true);
    final order_State = Provider.of<OrderState>(context, listen: true);
    final orderdetail_State = Provider.of<OrderDetailState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Siparişlerim"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: order_State.orders.length,
            itemBuilder: (context, index) {
              final order = order_State.orders[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                      key: Key(order_State.orders[index].LOGICALREF.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        cartState.clear2(index);
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            SvgPicture.asset("assets/icons/Trash.svg"),
                          ],
                          
                        ),
                      ),
                      child: product_State.products_customer.isNotEmpty &&
                              orderdetail_State.ordersDetails.isNotEmpty
                          ? MyOrdersScreen(
                              product: product_State.products_customer[index],
                              order: order,
                              orderDetails: orderdetail_State.ordersDetails[index],
                            )
                          : const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "-- Sipariş Yok --",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )));
            }),
            
      ),
    );
  }
}
