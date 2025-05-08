import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Shopping Cart'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body:
          cartProvider.cartItems.isEmpty
              ? Center(child: Text('Cart is empty'))
              : ListView.builder(
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartProvider.cartItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // 商品图片
                          Container(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              item.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${item.price.toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          // 数量控制
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed:
                                    () => cartProvider.decrementQuantity(index),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed:
                                    () => cartProvider.incrementQuantity(index),
                              ),
                            ],
                          ),
                          // 删除按钮
                          IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () => cartProvider.removeItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            'CHECKOUT (\$${cartProvider.totalPrice.toStringAsFixed(2)})',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
