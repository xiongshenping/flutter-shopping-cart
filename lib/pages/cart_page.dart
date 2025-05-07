import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Column(
      children: [
        AppBar(title: Text("Shopping Cart")),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return ListTile(
                leading: Image.network(item.product.imageUrl, width: 60),
                title: Text(item.product.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('¥${item.product.price.toStringAsFixed(2)}'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: item.quantity > 1
                              ? () => cart.changeQuantity(
                              item.product, item.quantity - 1)
                              : null,
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => cart.changeQuantity(
                              item.product, item.quantity + 1),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Total: ¥${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (cart.items.isEmpty) return;
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Success"),
                      content: Text("Payment successful!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            cart.clearCart();
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: Text("Pay Now"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
