import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    // Atualizando o item atual
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existentItem) => CartItem(
          id: existentItem.id,
          productId: existentItem.productId,
          name: existentItem.name,
          quantity: existentItem.quantity + 1,
          price: existentItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
