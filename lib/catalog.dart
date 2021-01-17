import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/bloc/cart_bloc.dart';
import 'package:flutter_cart/cart.dart';
import 'package:flutter_cart/item.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Item> _itemList = itemList;

  @override
  Widget build(BuildContext context) {
    final _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        actions: [IconButton(icon: Icon(Icons.archive), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => Cart()));
        })],
      ),
      body: BlocBuilder<CartBloc, List<Item>>(
        bloc: _cartBloc,
        builder: (BuildContext context, List state) {
          return Center(
            child: ListView(
              children: _itemList
                  .map((e) => _buildItem(e, state, _cartBloc))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(Item item, List state, CartBloc cartBloc) {
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
              setState(() {
                if (isChecked) {
                  cartBloc.add(CartEvent(CartEventType.remove, item));
                } else {
                  cartBloc.add(CartEvent(CartEventType.add, item));
                }
              });
            },
          ),
        ));
  }
}
