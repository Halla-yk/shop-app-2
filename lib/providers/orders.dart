import 'package:flutter/material.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(this.id, this.amount, this.products, this.dateTime);
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderItems;

  List<OrderItem> get oredrs {
    return [..._orderItems];
  }

  void addOrder(List<CartItem> orderItems, int amount) {
    _orderItems.insert(
        0,
        OrderItem(
            DateTime.now().toString(),
            amount,
            orderItems,
            DateTime
                .now())); //لو استخدمت add رح يضيف من ورا ..الحل اني استخدم  insert  واحط ال  index 0  علشان يضيف من قدام
    notifyListeners();
  }
}
