import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/blocs/cart_bloc.dart';
import 'package:flutter_bloc_example/models/cart.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _paymentType = "cash";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state.cart.items.isEmpty) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surfaceVariant,
          appBar: AppBar(
            title: const Text('Check Out'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      radius: 100,
                      child: Icon(Icons.payment,
                          size: 100, color: theme.colorScheme.primary),
                    ),
                    _buildTotalPrice(state.cart, theme),
                  ],
                ),
              ),
              _buildPaymentOptions(theme),
            ],
          ),
          bottomNavigationBar: _buildCheckoutButton(theme),
        );
      },
    );
  }

  Widget _buildTotalPrice(Cart cart, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Total",
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "\$${cart.totalPrice.toStringAsFixed(2)}",
            style: theme.textTheme.displaySmall!.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Text(
            "Payment Options",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        RadioListTile<String>(
          value: "cash",
          groupValue: _paymentType,
          onChanged: (value) {
            setState(() {
              _paymentType = value!;
            });
          },
          title: Text("Cash"),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        RadioListTile<String>(
          value: "card",
          groupValue: _paymentType,
          onChanged: (value) {
            setState(() {
              _paymentType = value!;
            });
          },
          title: Text("Credit Card"),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        )
      ],
    );
  }

  Widget _buildCheckoutButton(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: _checkout,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Checkout",
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: theme.colorScheme.onPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkout() {
    context.read<CartBloc>().add(Checkout());
  }
}
