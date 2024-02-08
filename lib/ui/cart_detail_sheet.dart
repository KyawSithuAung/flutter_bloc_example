import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/blocs/cart_bloc.dart';
import 'package:flutter_bloc_example/models/cart.dart';
import 'package:flutter_bloc_example/ui/checkout_screen.dart';

class CartDetailSheet extends StatefulWidget {
  const CartDetailSheet({super.key});

  @override
  State<CartDetailSheet> createState() => _CartDetailSheetState();
}

class _CartDetailSheetState extends State<CartDetailSheet> {
  late CartBloc _cartBloc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        _cartBloc = context.read<CartBloc>();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Text(
                "Cart",
                style: theme.textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _buildCartItems(state.cart, theme),
              ),
            ),
            _buildTotalPrice(state.cart, theme),
          ],
        );
      },
    );
  }

  Widget _buildCartItems(Cart cart, ThemeData theme) {
    if (cart.items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: const Text('Tap + to add items to the cart.'),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        var cartItem = cart.items[index];
        return ListTile(
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Text(cartItem.item.name),
          subtitle: Text('\$${cartItem.item.price}'),
          trailing: _buildQuantityControl(context, cartItem),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: cart.items.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }

  Widget _buildTotalPrice(Cart cart, ThemeData theme) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: _proceedToCheckout,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Total:',
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      cart.totalPrice.toStringAsFixed(2),
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    if (cart.items.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.shopping_cart_checkout,
                          size: 18,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityControl(BuildContext context, CartItem cartItem) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _decreaseQuantity(context, cartItem),
          icon: const Icon(Icons.remove_circle),
        ),
        Text(
          cartItem.count.toString(),
        ),
        IconButton(
          onPressed: () => _increaseQuantity(context, cartItem),
          icon: const Icon(Icons.add_circle),
        ),
      ],
    );
  }

  void _decreaseQuantity(BuildContext context, CartItem cartItem) {
    context.read<CartBloc>().add(RemoveFromCart(item: cartItem.item));
  }

  void _increaseQuantity(BuildContext context, CartItem cartItem) {
    context.read<CartBloc>().add(AddToCart(item: cartItem.item));
  }

  void _proceedToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _cartBloc,
          child: const CheckoutScreen(),
        ),
      ),
    );
  }
}
