import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  final Function(Product) onProductTap;

  HomePage({required this.onProductTap});

  final List<Product> products = [
    Product(
        id: 1,
        name: 'Apple',
        imageUrl: 'https://via.placeholder.com/150',
        price: 3.5,
        description: 'Fresh red apples.'),
    Product(
        id: 2,
        name: 'Banana',
        imageUrl: 'https://via.placeholder.com/150',
        price: 2.0,
        description: 'Imported sweet bananas.'),
    Product(
        id: 3,
        name: 'Orange',
        imageUrl: 'https://via.placeholder.com/150',
        price: 4.2,
        description: 'Juicy oranges.'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, index) => ProductCard(
        product: products[index],
        onTap: () => onProductTap(products[index]),
      ),
    );
  }
}
