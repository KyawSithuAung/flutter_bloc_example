import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/blocs/cart_bloc.dart';
import 'package:flutter_bloc_example/models/item.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final _items = [
    Item(name: 'Item 1', price: 10),
    Item(name: 'Item 2', price: 20),
    Item(name: 'Item 3', price: 30),
    Item(name: 'Item 4', price: 40),
    Item(name: 'Item 5', price: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = _items[index];
        return ListTile(
          leading: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Text(item.name),
          subtitle: Text('\$${item.price}'),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addToCart(item),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _items.length,
    );
  }

  void _addToCart(Item item) {
    BlocProvider.of<CartBloc>(context).add(AddToCart(item: item));
  }
}
