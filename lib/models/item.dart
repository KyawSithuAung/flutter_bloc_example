import 'package:equatable/equatable.dart';

class Item with EquatableMixin {
  String name;
  double price;

  Item({required this.name, required this.price});

  @override
  List<Object?> get props => [name, price];
}
