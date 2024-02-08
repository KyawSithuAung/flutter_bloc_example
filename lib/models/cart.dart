import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_example/models/item.dart';

class CartItem with EquatableMixin {
  final Item item;
  final int count;

  CartItem({required this.item, required this.count});

  @override
  List<Object?> get props => [item, count];
}

class Cart with EquatableMixin {
  final List<CartItem> items;

  Cart({required this.items});

  @override
  List<Object?> get props => [items];

  Cart copy() {
    return Cart(items: List<CartItem>.from(items));
  }

  double get totalPrice {
    return items.fold(
        0, (total, current) => total + current.item.price * current.count);
  }

  int get totalItems {
    return items.fold(0, (total, current) => total + current.count);
  }

  void addItem(Item item) {
    final index = items.indexWhere((element) => element.item.name == item.name);
    if (index != -1) {
      items[index] =
          CartItem(item: items[index].item, count: items[index].count + 1);
    } else {
      items.add(CartItem(item: item, count: 1));
    }
  }

  void removeItem(Item item) {
    final index = items.indexWhere((element) => element.item.name == item.name);
    if (index != -1) {
      if (items[index].count > 1) {
        items[index] =
            CartItem(item: items[index].item, count: items[index].count - 1);
      } else {
        items.removeAt(index);
      }
    }
  }

  void checkout() {
    items.clear();
  }
}
