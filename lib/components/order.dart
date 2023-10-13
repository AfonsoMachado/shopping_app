import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  double turns = 0.0;

  void _changeRotation() {
    setState(() => turns += 0.5);
  }

  @override
  Widget build(BuildContext context) {
    final itemsHeight = (widget.order.products.length * 25.0) + 10.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _expanded ? itemsHeight + 80 : 80,
      child: Card(
        child: Column(
          children: [
            ListTile(
                title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
                subtitle: Text(
                    DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date)),
                trailing: AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    icon: const Icon(Icons.expand_more),
                    // Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                        _changeRotation();
                      });
                    },
                  ),
                )),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _expanded ? itemsHeight : 0,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${product.quantity}x R\$ ${product.price.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      )
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
