import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/app_drawer.dart';
import 'package:shopping_app/components/product_item.dart';
import 'package:shopping_app/models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(
                product: products.items[i],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}