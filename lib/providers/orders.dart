import './cart.dart';
import 'package:flutter/material.dart';

class OrderItem {
  // final String title;
  final String id;
  final double amount;
  final List<CartItem> products; //to find which products were ordered
  final DateTime dateTime;

  OrderItem(
      // {@required this.title,
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders]; //so that we cant edit orders outside the class
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    // _orders.insert(index, element) =>to add at the beginning of the list
    //Inserts [element] at position [index] in this list.
    //This increases the length of the list by one and shifts all objects at or after
    //the index towards the end of the list.
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now()),
    );

    notifyListeners();
  }
}

