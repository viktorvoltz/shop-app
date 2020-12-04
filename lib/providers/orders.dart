import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;

class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Order with ChangeNotifier{
  List<OrderItem> _orders = [];

  List<OrderItem> get order{
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://flutter-shopapp-41166.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(url, body: json.encode({
      'amount': total,
      'dateTime': timeStamp.toIso8601String(),
      'products': cartProducts.map((e) =>
        {'id': e.id,
        'title':e.title,
        'quantity': e.quantity,
        'price': e.price,}
      ).toList(),
    }));
    if(total == 0.0){
      return null;
    }
    _orders.insert(0, OrderItem(id: json.decode(response.body)['name'], amount: total, dateTime: DateTime.now(), products: cartProducts),);
  }

  notifyListeners();
}