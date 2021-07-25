import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  // const OrdersScreen({ Key? key }) : super(key: key);

  static const routeName ='/orders-screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders=>Orders Screen'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, index) {
            return OrderItemWidget(orderData.orders[index]);
          }),
    );
  }
}
