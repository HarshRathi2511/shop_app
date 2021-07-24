import 'package:flutter/material.dart';

class CartItem {
  final String id; //not the id of the product
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.title,
      @required this.id,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {}; //id =>CartItem map

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    //if item already present just increase quantity
    if (_items.containsKey(productId)) {
      //change quantity
      _items.update(  //Updates the value for the provided [key].
          productId,
          (existingCartItemValue) => CartItem(
              id: existingCartItemValue.id,
              title: existingCartItemValue.title,
              price: existingCartItemValue.price,
              quantity: existingCartItemValue.quantity +1)); 
      //existingCartItemValue =>automatically has the existing data
    } else {
      _items.putIfAbsent(  //Look up the value of [key], or add a new entry if it isn't there.
          productId,
          () => CartItem(
              title: title,
              id: DateTime.now().toString(),
              price: price,
              quantity: 1));
    }
  }
}
