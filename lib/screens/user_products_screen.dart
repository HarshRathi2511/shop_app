//for us to add or delete files
//list of all the products of the user
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  // const UserProductsScreen({ Key? key }) : super(key: key);

  static const routeName ='/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(' Manage products'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {

        })],
      ),
      
      drawer: AppDrawer(),

      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<Products>(
          builder: (ctx, products, child) {
            return ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (c, i) {
                  return UserProductItem(
                      title: productsData.items[i].title,
                      imageUrl: productsData.items[i].imageUrl);
                });
          },
        ),
      ),
    );
  }
}
//ListView.builder(itemCount: ,itemBuilder: (ctx,index){})
