import "package:flutter/material.dart";
import "package:sippy_ca/core/config/get_it_setup.dart";
import "package:sippy_ca/features/homepage/data/models/beverage.dart";
import "package:sippy_ca/features/product/data/model/cart_item_model.dart";
import "package:sippy_ca/features/product/data/repository/product_repository.dart";
import "package:sippy_ca/utils/dialog_services.dart";

class ProductProvider extends ChangeNotifier {
  bool addingToCart = false;
  bool get addingToCartStatus => addingToCart;

  bool _fetchingCartItems = false;
  bool get fetchedCartItems => _fetchingCartItems;

  bool _deletingCartItem = false;
  bool get deletingCartItemStatus => _deletingCartItem;

  List<CartItemModel> _cartItems = [];
  List<CartItemModel> get getCartItems => _cartItems;

  ProductRepository productRepository;

  ProductProvider(this.productRepository);

  void addToCart(
      {required BeverageItem beverage,
      required int quantity,
      required String cartId,
      required Map<String, String> addedBy}) async {
    addingToCart = true;
    notifyListeners();
    try {
      await productRepository.addToCart(beverage, quantity, cartId, addedBy);
      getIt<DialogServices>().showMessage("Item has been added to cart");
    } catch (e) {
      getIt<DialogServices>().showMessageError(e.toString());
    } finally {
      addingToCart = false;
      notifyListeners();
    }
  }

  void fetchCartItems(String cartId, bool init) async {
    _fetchingCartItems = true;
    if (!init) {
      notifyListeners();
    }
    try {
      _cartItems = await productRepository.fetchCartItems(cartId);
    } catch (e) {
      getIt<DialogServices>().showMessageError(e.toString());
    } finally {
      _fetchingCartItems = false;
      notifyListeners();
    }
  }

  void removeFromCart(String documentId, Function callback) async {
    _deletingCartItem = true;
    notifyListeners();
    try {
      await productRepository.deleteCartItem(documentId);
      getIt<DialogServices>().showMessage("Item has been removed from cart");
      callback();
    } catch (e) {
      getIt<DialogServices>().showMessageError(e.toString());
    } finally {
      _deletingCartItem = false;
      notifyListeners();
    }
  }
}
