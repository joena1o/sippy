import 'package:sippy_ca/features/homepage/data/models/beverage.dart';

class CartModel {
  final String id;
  final String cartId;
  final BeverageItem beverageItem;
  final int quantity;
  final String addedBy;

  CartModel(
      {required this.id,
      required this.cartId,
      required this.beverageItem,
      required this.addedBy,
      required this.quantity});
}
