//Widget for each grid item that gets rendered on the product overview screen

import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem({ Key? key }) : super(key: key);
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {

   final product=Provider.of<Product>(context);
  



    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
          child: GridTile(
        child: InkWell(

          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
          },

          splashColor: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
           product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTileBar(
            //The widget to show over the bottom of this grid tile.//Typically a [GridTileBar].
            backgroundColor: Colors.black87,

            leading: IconButton(
              icon: Icon(product.isFavorite? Icons.favorite : Icons.favorite_border,
               color: Theme.of(context).accentColor), 
              //here we need Product data to know if it has already been marked favorite
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
             //A widget to display before the title.
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),

            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                
              },
            ),

          ),
        ),
      ),
    );
  }
}
