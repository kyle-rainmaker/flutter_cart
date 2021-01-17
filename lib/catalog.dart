import 'package:flutter/material.dart';
import 'package:flutter_cart/bloc/cart_bloc.dart';
import 'package:flutter_cart/cart.dart';
import 'package:flutter_cart/item.dart';
import 'package:flutter_cart/main.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        actions: [
          IconButton(
              icon: Icon(Icons.archive),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Cart()));
              })
        ],
      ),
      body: StreamBuilder(
        stream: cartBloc.cartList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: cartBloc.itemList
                  .map((item) => _buildItem(item, snapshot.data))
                  .toList(),
            );
          } else {
            return Center(
              child: Text(
                '노잼',
                style: TextStyle(fontSize: 30),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildItem(Item item, List<Item> state) {
    final isChecked = state.contains(item);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(fontSize: 31),
        ),
        subtitle: Text('${item.price}'),
        trailing: IconButton(
          icon: isChecked
              ? Icon(Icons.check, color: Colors.red)
              : Icon(Icons.check),
          onPressed: () {
            if (isChecked) {
              cartBloc.add(CartEvent(CartEventType.remove, item));
            } else {
              cartBloc.add(CartEvent(CartEventType.add, item));
            }
          },
        ),
      ),
    );
  }
}
