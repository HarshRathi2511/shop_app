//detailed page for each product
import 'package:flutter/material.dart';

import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  // const ProductDetailScreen({ Key? key }) : super(key: key);

  // final String title;
  // ProductDetailScreen(this.title);

  static const routeName='/product-detail';

  @override
  Widget build(BuildContext context) {
    
    final String productId=ModalRoute.of(context).settings.arguments as String;  
    //get id
    // final loadedProduct=Provider.of<Products>(context).items.firstWhere((prod) => prod.id==productId); 
    //better if the filtering logic is done inside the class 
    final Product loadedProduct=Provider.of<Products>(context,listen: false).findById(productId);
    //if say for some other logic the Products class changes =>automatically all the listeners will rebuild 
    //but we only want the id of the product the user selected ,and we dont care about further changes in the class
    //then we use (context,listen : false)


    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title),),
    );
  }
}