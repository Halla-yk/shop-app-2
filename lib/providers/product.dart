import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier{
   String id;
   String title;
   String description;
   double price;
   String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.description,
      @required this.imageUrl,
      this.isFavorite = false,
      @required this.price,
      @required this.title});

  void toggleFavoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

}
