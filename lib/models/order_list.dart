import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/models/order.dart';
import 'package:shopping_app/utils/constants.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.orderBaseUrl}.json'),
      body: jsonEncode(
        {
          "total": cart.totalAmount,
          "date": date.toIso8601String(),
          "products": cart.items.values
              .map((cartItem) => {
                    "id": cartItem.id,
                    "productId": cartItem.productId,
                    "name": cartItem.name,
                    "quantity": cartItem.quantity,
                    "price": cartItem.price,
                  })
              .toList()
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
          id: id,
          total: cart.totalAmount,
          date: date,
          products: cart.items.values.toList()),
    );
    notifyListeners();
  }
}
