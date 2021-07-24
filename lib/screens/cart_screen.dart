import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/cart_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  // const CartScreen({ Key? key }) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(), //takes up all the available space
                  Chip(
                    //rounded rectangle container type
                    label: Text(
                      '\$' + cart.totalAmountInCart.toString(),
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline1.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('ORDER NOW'),
                  )
                ]),
          ),
        ),
        SizedBox(height: 12),
        Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, i) => CartItemWidget(
                    title: cart.items.values.toList()[i].title,
                    id: cart.items.values.toList()[i].id,
                    price: cart.items.values.toList()[i].price,
                    quantity: cart.items.values.toList()[i].quantity)))
      ]),
    );
  }
}
