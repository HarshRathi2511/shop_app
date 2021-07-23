

//contains the list view which builds the overview screen
import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';




class ProductsGrid extends StatelessWidget {
  
 //add a listener 

  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<Products>(context) ; //only use this if directly or indirectly some provider
    // has been added to the parent widgets 
    //only this child widgets are rebuild 
    //<Products> by this we want to specify that we need communication chanel between the type 
    //of data i.e =>provided instance of the Products class and this widget 

    final products =productsData.items;  //'items' is the getter specefied in the Products class 




    return GridView.builder(

      padding: const EdgeInsets.all(10),

      itemCount: products.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //A delegate that controls the layout of the children within the [GridView].
        crossAxisCount: 2,
        childAspectRatio: 3/2, //The ratio of the cross-axis to the main-axis extent of each child.),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),

      itemBuilder: (BuildContext ctx, int index) {
        return ProductItem(products[index].id,products[index].title, products[index].imageUrl);
      },
    );
  }
}