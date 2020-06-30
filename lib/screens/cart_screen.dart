import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' ; // show cart
import '../widgets/cart_item.dart' as ci;
import '../providers/orders.dart';
class CartScreen extends StatelessWidget {
  static const routeName = "/cartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("your cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  FlatButton(onPressed: () {
                    Provider.of<Orders>(context, listen: false).addOrder(cart.items.values, cart.itemCount);
                    cart.clear();
                  }, child: Text("ORDER NOW"))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),Container(),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx,index)=>ci.CartItem(
                id: cart.items.values.toList()[index].id,
                productId: cart.items.keys.toList()[index],
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                title: cart.items.values.toList()[index].title),
                itemCount: cart.itemCount,
          ))
        ],
      ),
    );
  }
}
