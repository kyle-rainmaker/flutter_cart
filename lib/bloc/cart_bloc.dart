import 'package:flutter_cart/item.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:rxdart/rxdart.dart';

enum CartEventType { add, remove }

class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);
}

class CartBloc {
  final itemList = [
    Item('맥북', 2000000),
    Item('생존코딩', 32000),
    Item('될때까지 안드로이드', 40000),
    Item('새우깡', 1200),
    Item('신라면', 2000)
  ];

  final _cartList = List<Item>();
  final _cartListSubject = BehaviorSubject<List<Item>>.seeded([]);
  // final _cartListSubject = BehaviorSubject<List<Item>>();

  Stream<List<Item>> get cartList => _cartListSubject.stream;

  void add(CartEvent event) {
    switch(event.type) {
      case CartEventType.remove:
        _cartList.remove(event.item);
        break;
      case CartEventType.add:
        _cartList.add(event.item);
        break;
    }

    _cartListSubject.add(_cartList);
  }
}