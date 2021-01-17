import 'package:flutter/material.dart';
import 'package:flutter_cart/main.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: StreamBuilder(
        stream: cartBloc.cartList,
        builder: (context, snapshot) {
          var sum = 0;

          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              sum = snapshot.data.map((e) => e.price).reduce((x, y) => x + y);
            }
          }

          return Center(
            child: Text(
              '합계 : $sum',
              style: TextStyle(fontSize: 30),
            ),
          );
        },
      ),
    );
  }
}
