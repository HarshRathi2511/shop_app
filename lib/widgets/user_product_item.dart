//how each widget looks on the user screen .dart 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class UserProductItem extends StatelessWidget {
  // const UserProductItem({ Key? key }) : super(key: key);

  final String title;
  final String imageUrl;

  UserProductItem({this.title,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
          child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl)
          ),
        trailing: Container(
          width: 100,
          child: Row(children:[
            IconButton(icon: Icon(Icons.edit),onPressed: (){},color: Theme.of(context).primaryColor,),
            IconButton(icon: Icon(Icons.delete),onPressed: (){},color: Theme.of(context).errorColor,)
          ]),
        ),
      ),
    );
  }
}