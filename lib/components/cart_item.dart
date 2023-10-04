import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget(
    this.cartItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(cartItem.name);
  }
}
