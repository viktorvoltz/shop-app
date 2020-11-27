import 'package:flutter/material.dart';
import '../screens/products_overview_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Shop'),
            onTap: (){
              Navigator.of(context).pushNamed('/orders');
            },
          ),
          
            
          
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: (){
               Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
