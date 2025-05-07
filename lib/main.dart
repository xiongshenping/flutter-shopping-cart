import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/product_detail_page.dart';
import 'models/product.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BottomNavController(),
    );
  }
}

class BottomNavController extends StatefulWidget {
  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _selectedIndex = 0;
  Product? _currentProduct;

  void _navigateToDetail(Product product) {
    setState(() {
      _currentProduct = product;
    });
  }

  void _goBackFromDetail() {
    setState(() {
      _currentProduct = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_currentProduct != null) {
      body = ProductDetailPage(
        product: _currentProduct!,
        onBack: _goBackFromDetail,
      );
    } else if (_selectedIndex == 0) {
      body = HomePage(onProductTap: _navigateToDetail);
    } else {
      body = CartPage();
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
        onTap: (index) {
          setState(() {
            _currentProduct = null;
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
