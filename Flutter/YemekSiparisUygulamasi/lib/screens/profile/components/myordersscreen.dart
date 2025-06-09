import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/OrderDetailsModel.dart';
import 'package:shop_app/models/OrderModel.dart';
import 'package:shop_app/models/ProductModel.dart';
import 'package:shop_app/models/state/OrderDetailsState.dart';
import 'package:shop_app/models/state/OrderState.dart';

class MyOrdersScreen extends StatelessWidget {
  final Product? product;
  final Order order;
  final OrderDetails? orderDetails;
  const MyOrdersScreen({super.key, this.product, required this.order, this.orderDetails});

  @override
  Widget build(BuildContext context) {
    final order_state = Provider.of<OrderState>(context, listen: true);
    final orderdetails_state = Provider.of<OrderDetailState>(context, listen: true);

    final orderDetailsForThisOrder = orderdetails_state.ordersDetails
        .where((orderDetail) => orderDetail.ORDERREF == order.LOGICALREF)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color(0xFFF5F6F9),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          /* leading: SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: product.IMAGE.isNotEmpty
                    ? Image.asset(
                        product.IMAGE,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/default_image.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),*/
          title: Text(
            product != null ? order.ORDER_DATE_TIME : 'Ürün bulunamadı',
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
              SizedBox(height: 2),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: orderDetailsForThisOrder
                    .map((orderDetail) => Text(
                          "/" + orderDetail.STOCK_NAME,
                          style: TextStyle(fontSize: 10),
                        ))
                    .toList(),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    order.SHIP_ADDRESS.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    order.ORDER_STATUS.toString(),
                    style: TextStyle(fontSize: 10, color: Colors.green),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Tutar:  " + order.ORDER_TOTAL_PRICE.toString() + " TL",
                  style: const TextStyle(
                    fontSize: 12,
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
