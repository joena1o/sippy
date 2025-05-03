import 'package:sippy_ca/core/data/data_sources/firestore_service.dart';
import 'package:sippy_ca/features/homepage/data/models/beverage.dart';
import 'package:sippy_ca/features/product/data/model/cart_item_model.dart';

class ProductRepository {
  ProductRepository({required this.firestoreService});
  FirestoreService firestoreService;

  Future<void> addToCart(BeverageItem beverage, int quantity, String cartId,
      Map<String, String> addedBy) async {
    try {
      // Step 1: Check if item already exists in cart
      final querySnapshot = await firestoreService.firestore
          .collection("cart_items")
          .where("item_id", isEqualTo: beverage.itemId)
          .where("cart_id", isEqualTo: cartId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;

        await firestoreService.firestore
            .collection("cart_items")
            .doc(doc.id)
            .update({
          "quantity": quantity,
        });
      } else {
        await firestoreService.firestore.collection("cart_items").add({
          "createdBy": addedBy,
          "quantity": quantity,
          "item_id": beverage.itemId,
          "cart_id": cartId,
        });
      }
    } catch (e) {
      throw ("Failed to add to cart: ${e.toString()}");
    }
  }

  Future<List<CartItemModel>> fetchCartItems(String cartId) async {
    try {
      final querySnapshot = await firestoreService.firestore
          .collection("cart_items")
          .where("cart_id", isEqualTo: cartId)
          .get();

      final cartItems = querySnapshot.docs
          .map((cartItem) => CartItemModel.fromJson(
              {"documentId": cartItem.id, ...cartItem.data()}))
          .toList();
      return cartItems;
    } catch (e) {
      throw ("Failed to fetch cart items $e");
    }
  }

  Future<void> deleteCartItem(String documentId) async {
    try {
      await firestoreService.deleteDocument(
          collectionPath: "cart_items", documentId: documentId);
    } catch (e) {
      throw ("Failed to delete cart item $e");
    }
  }
}
