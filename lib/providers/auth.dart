import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCJQajRW-sqEE88eHw4s5hgZ1QvJd-Qj6k';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email, 
          'password': password, 
          'returnSecureToken': true},
      ),
    );
    print(json.decode(response.body));
  }
}