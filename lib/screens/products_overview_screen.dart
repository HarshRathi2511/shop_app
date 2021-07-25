import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';

enum FilterOptionsPopUp {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  // const ProductsOverviewScreen({ Key? key }) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    // print('Build Method of Build OverView Screen Ran');

    return Scaffold(
      appBar: AppBar(
        title: Text('Products Overview Screen'),
        actions: [
          PopupMenuButton(
            //a small pop up
            onSelected: (FilterOptionsPopUp selectedValue) {
              setState(() {
                if (selectedValue == FilterOptionsPopUp.Favorites) {
                  //0=>Favorites
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
                print('setState ran');
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (c) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value:
                    FilterOptionsPopUp.Favorites, //define enum for readability
              ),
              PopupMenuItem(
                child: Text('Show All Products'),
                value: FilterOptionsPopUp.All,
              )
            ],
          ), //{List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder}

          Consumer<Cart>(
              builder: (context, cart, ch) => Badge(                  
                    child: ch,
                    value: cart.itemCount.toString(),
                  ),
                  child: IconButton( icon: Icon(Icons.shopping_cart), onPressed: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  }),
                  ),
                  //this icon button is automatically connected to 'ch'
        ],
      ),

      drawer: AppDrawer(),

      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
