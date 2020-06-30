import 'package:flutter/material.dart';
import '../providers/product.dart';
import 'product_item.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
class ProductsGrid extends StatelessWidget {
 var _showOnlyFav;
  ProductsGrid(this._showOnlyFav);

//كانت هادي ال widget محطوطة بال products_overview  بس حطيتها ب file  لحالها علشان لما يصير تغير بال provider بس يعمل لهاي rebuild
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);//بعمل listen  لكل widget interested بال products
    final products = _showOnlyFav?productsData.favoriteItems:productsData.items;//هادي الlist جبناها من ال provider
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(// بتعتمد عال product
         // builder: (ctx) =>products[i],//بدي provider لكل product بحيث انه لو صار تغير في ال data تبعت ال item الواحدالموجود في ال array
          value:  products[i],//بنستخدم هاي الطريقة لما بدنا نعمل provider لل لكل item ب list او grid
            child: ProductItem(//هادي بصير عندها علم بالتغيرات تبعت ال item الخاص فيها بس//وبتاخد المعلومات من ال item تبعها
//              products[i].title, products[i].id,
//              products[i].imageUrl,
            )
        )
          ;
      },
      itemCount: products.length,
    );

  }
}
