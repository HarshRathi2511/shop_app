import 'package:flutter/material.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('Build Method of Main Ran');

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            //ChangeNotifierProvider is a provider by the package
            //cleans up the data once used=>eg screen replaced
            create: (ctx) => Products(),
          ), //new one and the same instance of the provider class to the MaterialApp and all its children
          //whenever you reuse an existing object => use .value constructor
          //whenever you instantiate a class =>create a new object on a class ==>use create method
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Orders(),
          )
        ],
        child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.orange,
              fontFamily: 'Lato'),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
          },
          //we need to provide the data at the highest point of the widget tree ,
          //such that it is one hierarchy above the listeners
          //eg -> if we need a data in product_item.dart then we could provide the data in the product_overview_screen.dart
          //=>not necessary to provide in the main.dart
        ));
  }
}
