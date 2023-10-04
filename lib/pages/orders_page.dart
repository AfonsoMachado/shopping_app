import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/app_drawer.dart';
import 'package:shopping_app/components/order.dart';
import 'package:shopping_app/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i])),
    );
  }
}
