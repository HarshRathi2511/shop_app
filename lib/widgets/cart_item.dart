//widget for each card in the Your Cart screen

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  // const CartItemWidget({ Key? key }) : super(key: key);

  final String id;
  final double price;
  final String title;
  final int quantity;

  CartItemWidget({this.id, this.price, this.title, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$ $price ')),
          ),
          title: Text(title),
          subtitle: Text('Total:\$' + (price * quantity).toString()),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
