import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/blocs/cart_bloc.dart';

class CartIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const CartIcon({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        var itemCount = state.cart.totalItems;

        return ActionChip(
          onPressed: onPressed,
          avatar: Icon(
            Icons.shopping_cart,
            color: theme.colorScheme.onPrimaryContainer,
          ),
          label: Text(
            itemCount.toString(),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          backgroundColor: theme.colorScheme.primaryContainer,
        );
      },
    );
  }
}
