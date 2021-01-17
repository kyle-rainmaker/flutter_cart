// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/item.dart';
import 'package:bloc/bloc.dart';

enum CartEventType { add, remove }

class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);
}

class CartBloc extends Bloc<CartEvent, List<Item>> {
  List<Item> items = [];

  @override
  List<Item> get initialState => [];

  @override
  Stream<List<Item>> mapEventToState(CartEvent event) async* {
    switch(event.type) {
      case CartEventType.add:
        items.add(event.item);
        break;
      case CartEventType.remove:
        items.remove(event.item);
        break;
    }
    yield items;
  }
}

// enum CartEventType { add, remove }
//
// class CartEvent {
//   final CartEventType type;
//   final Item item;
//
//   CartEvent(this.type, this.item);
// }
//
// class CartBloc extends Bloc<CartEvent, List<Item>> {
//   // CartBloc(List<Item> initialState) : super(initialState);
//   List<Item> items = [];
//
//   CartBloc(List<Item> initialState) : super(initialState);
//
//   @override
//   List<Item> get initialState => [];
//
//   @override
//   Stream<List<Item>> mapEventToState(CartEvent event) async* {
//     switch (event.type) {
//       case CartEventType.add:
//         items.add(event.item);
//         break;
//       case CartEventType.remove:
//         items.remove(event.item);
//         break;
//     }
//
//     yield items;
//   }
// }
