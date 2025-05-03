import 'package:flutter/material.dart';
import 'package:sippy_ca/features/cart_page.dart/data/model/cart_model.dart';
import 'package:sippy_ca/features/homepage/data/models/shopping_invite_model.dart'
    show ShoppingInviteModel;

class CartProvider extends ChangeNotifier {
  List<CartModel> _cartItems = [];
  List<CartModel> get getCartItems => _cartItems;

  ShoppingInviteModel? _cartSession;
  ShoppingInviteModel? get getCartSession => _cartSession;

  void setCartSession(ShoppingInviteModel? session) {
    _cartSession = session;
    notifyListeners();
  }

  void addItemToCart(CartModel cartItem) {
    final existingItemIndex = _cartItems.indexWhere(
      (item) => item.beverageItem.name == cartItem.beverageItem.name,
    );

    if (existingItemIndex != -1) {
      // Beverage already exists, update quantity
      final existingItem = _cartItems[existingItemIndex];
      _cartItems[existingItemIndex] = CartModel(
        id: existingItem.id,
        cartId: existingItem.cartId,
        beverageItem: existingItem.beverageItem,
        addedBy: existingItem.addedBy,
        quantity:
            existingItem.quantity + cartItem.quantity, // Increase quantity
      );
    } else {
      // New beverage, add to list
      _cartItems = [..._cartItems, cartItem];
    }

    notifyListeners();
  }
}
