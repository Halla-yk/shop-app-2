import 'package:flutter/material.dart';
import 'package:flutter_app/screens/edit_product_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_product_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application. 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (ctx) => Products()),
        ChangeNotifierProvider(
          builder: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(builder: (ctx) =>Orders() ,)
      ],
      child: MaterialApp(
        title: 'My shop',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.redAccent,
        ),
        home: ProductsOverviewScreen(),
        routes: {ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                 CartScreen.routeName : (ctx) => CartScreen(),
                 OrdersScreen.routeName: (ctx) => OrdersScreen(),
                 UserProductScreen.routeName:(ctx) => UserProductScreen(),
                 EditProductScreen.routeName: (ctx) => EditProductScreen()
                 },
      ),
    );
  }
}
