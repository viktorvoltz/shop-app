import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Order;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  Future _ordersFuture;

  Future _obtainOrdersFuture(){
    return Provider.of<Order>(context, listen: false).fetchOrder();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(future: _ordersFuture, builder: (ctx, dataSnaphot) {
       if(dataSnaphot.connectionState == ConnectionState.waiting){
         return Center(child: CircularProgressIndicator());
       }else{
         if(dataSnaphot.error != null){
           return Center(child: Text('An error occured'));
         }else{
           return Consumer<Order> (builder: (ctx, orderData, child) => ListView.builder(
              itemCount: orderData.order.length,
              itemBuilder: (ctx, i) {
                return OrderItem(orderData.order[i]);
              }));
         }
       }
      },) 
          
          
    );
  }
}
