import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 60),
        title: Text(product.name),
        subtitle: Text('¥${product.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false)
                .addToCart(product);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Added to cart')));
          },
        ),
        onTap: onTap,
      ),
    );
  }
}
