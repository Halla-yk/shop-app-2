import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({@required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {}; //بستخدم ال  map علشان اربط اشيين مع بعض
  Map<String, CartItem> get items {
    return {..._items};
  }


//هون استخدمنا ال map  وال productId  ك value  علشان الاضافة وتزويد ال quantity عن طريق زر ال cart  اللي بال product مش عن طريق زر plus موجود بال cartItem
  //لو كان في زر plus كنت بقدر اعمل list مش  map  وكنت ببحث عن ازا ال cart item  موجود عن طريق ال id تبعه باستخدام for each
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
              (existingCartItem) =>
              CartItem(
                  id: existingCartItem.id,
                  price: existingCartItem.price,
                  title: existingCartItem.title,
                  quantity: existingCartItem.quantity + 1)); //199
      //change quantity
    } else {
      _items.putIfAbsent( //بتضيف key و value
          productId,
              () =>
              CartItem(
                  id: DateTime.now().toString(),
                  title: title,
                  price: price,
                  quantity: 1));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length; //بترجع عدد ال product بدون ال quantity
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((product, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId); //بتحذف key and value
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId, (existingCartItem) =>
          CartItem(id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1
          ));
          }
    else{
      _items.remove(productId);
    }
          notifyListeners();
    }

  void clear() {
    _items = {};
  }

}
