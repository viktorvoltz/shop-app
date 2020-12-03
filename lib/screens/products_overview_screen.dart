import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import 'cart_screen.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = 'products-overview';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context, listen: false).fetchAndSetProducts(); OR
    /*Future.delayed(Duration.zero).then((value){
      Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    });*/
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try{
      await Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts()
          .then((_) {
            setState(() {
              _isLoading = false;
            });
      });} catch (error){
        await showDialog(
          context: context, 
          builder: (ctx) {
          return AlertDialog(
            title: Text('Internet Connection'),
            content: Text('Check internet connection'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: (){
                  Navigator.of(ctx).pop();
                }
              )
            ]
            );
        });
      }
      finally{
        setState(() {
          _isLoading = false;
        });
        
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(
                  () {
                    if (selectedValue == FilterOptions.Favourites) {
                      _showOnlyFavourites = true;
                    } else {
                      _showOnlyFavourites = false;
                    }
                  },
                );
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('only Favoriotes'),
                    value: FilterOptions.Favourites),
                PopupMenuItem(
                    child: Text('Show All'), value: FilterOptions.All),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ProductsGrid(_showOnlyFavourites));
  }
}
