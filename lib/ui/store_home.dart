import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/blocs/cart_bloc.dart';
import 'package:flutter_bloc_example/ui/cart_detail_sheet.dart';
import 'package:flutter_bloc_example/ui/cart_icon.dart';
import 'package:flutter_bloc_example/ui/item_list.dart';

class StoreHome extends StatefulWidget {
  const StoreHome({Key? key}) : super(key: key);

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  late CartBloc _cartBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          _cartBloc = context.read<CartBloc>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('BLoC Store'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CartIcon(
                    onPressed: _showCartDetail,
                  ),
                ),
              ],
            ),
            body: const ItemList(),
          );
        },
      ),
    );
  }

  void _showCartDetail() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider<CartBloc>.value(
            value: _cartBloc, child: const CartDetailSheet());
      },
    );
  }
}
