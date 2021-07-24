import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

import '../widgets/products_grid.dart';

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
    print('Build Method of Build OverView Screen Ran');

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
        ],
      ),
      
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
