import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/models/cart.dart';
import 'package:flutter_bloc_example/models/item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(Cart(items: []))) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<Checkout>(_checkout);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    var cart = state.cart.copy();
    cart.addItem(event.item);
    emit(state.copyWith(cart: cart));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    var cart = state.cart.copy();
    cart.removeItem(event.item);
    emit(state.copyWith(cart: cart));
  }

  void _checkout(Checkout event, Emitter<CartState> emit) {
    if (state.cart.items.isEmpty) {
      return;
    }

    var cart = state.cart.copy();
    cart.checkout();
    emit(state.copyWith(cart: cart));
  }
}

sealed class CartEvent extends Equatable {}

class AddToCart extends CartEvent {
  final Item item;

  AddToCart({required this.item});

  @override
  List<Object?> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final Item item;

  RemoveFromCart({required this.item});

  @override
  List<Object?> get props => [item];
}

class Checkout extends CartEvent {

  Checkout();

  @override
  List<Object?> get props => [];
}

class CartState with EquatableMixin {
  final Cart cart;

  CartState(this.cart);

  CartState copyWith({
    Cart? cart,
  }) {
    return CartState(cart ?? this.cart);
  }

  @override
  List<Object?> get props => [cart];
}
