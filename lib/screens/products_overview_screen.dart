import 'package:flutter/material.dart';
import 'package:flutter_app/providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
enum FiltersOption { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    //final products = Provider.of<Products>(context,listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('MY shop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FiltersOption f) {
                setState(() {
                  if (f == FiltersOption.Favorites)
                    _showOnlyFavorites = true;
                  else
                    _showOnlyFavorites = false;
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) =>
              [
                PopupMenuItem(
                  child: Text("only Favorites"),
                  value: FiltersOption.Favorites,
                ),
                PopupMenuItem(
                  child: Text("show all"),
                  value: FiltersOption.All,
                )
              ],
            ),
            Consumer<Cart>(
              builder: (ctx, cart, ch) =>
                  Badge(
                      child: ch,
                      value: cart.itemCount.toString())
              //فقط ال value هي المهتمة بالتغيير
              ,
              child: IconButton(
                  icon: Icon(Icons.shopping_cart), onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              }),
            )
          ],
        ),drawer: AppDrawer(),
        body: ProductsGrid(_showOnlyFavorites));
  }
}
