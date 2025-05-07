import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final VoidCallback onBack;

  const ProductDetailPage({required this.product, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(product.name),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: onBack),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(product.imageUrl,
                    width: double.infinity, height: 200, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(product.name,
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Text('¥${product.price.toStringAsFixed(2)}'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(product.description),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to cart')));
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
