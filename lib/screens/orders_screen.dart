import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  //convert to stateful to use didChangeDependencies etc
  // const OrdersScreen({ Key? key }) : super(key: key);

  static const routeName = '/orders-screen';

  var _isLoading = false;
  // var _isInit=true;

  // @override
  // void initState() {
  //  _isLoading=true;
  //   Provider.of<Orders>(context, listen: false)
  //       .fetchAndSetOrders()
  //       .then((value) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    print('build orders');

    return Scaffold(
        appBar: AppBar(
          title: Text('Orders Screen'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error == null) {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) {
                    return ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, index) {
                          return OrderItemWidget(orderData.orders[index]);
                        });
                  },
                );
              } else {
                return Center(child: Text(dataSnapshot.error.toString()));
              }
            }
          },
        ));
  }
}
