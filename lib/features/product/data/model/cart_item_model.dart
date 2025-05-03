// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  final String documentId;
  final String? cartId;
  final int? quantity;
  final CreatedBy? createdBy;
  final String? itemId;

  CartItemModel({
    required this.documentId,
    this.cartId,
    this.quantity,
    this.createdBy,
    this.itemId,
  });

  CartItemModel copyWith({
    String? documentId,
    String? cartId,
    int? quantity,
    CreatedBy? createdBy,
    String? itemId,
  }) =>
      CartItemModel(
        documentId: documentId ?? this.documentId,
        cartId: cartId ?? this.cartId,
        quantity: quantity ?? this.quantity,
        createdBy: createdBy ?? this.createdBy,
        itemId: itemId ?? this.itemId,
      );

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        documentId: json['documentId'],
        cartId: json["cart_id"],
        quantity: json["quantity"],
        createdBy: json["createdBy"] == null
            ? null
            : CreatedBy.fromJson(json["createdBy"]),
        itemId: json["item_id"],
      );

  Map<String, dynamic> toJson() => {
        "documentId": documentId,
        "cart_id": cartId,
        "quantity": quantity,
        "createdBy": createdBy?.toJson(),
        "item_id": itemId,
      };
}

class CreatedBy {
  final String? userId;
  final String? name;
  final String? email;

  CreatedBy({
    this.userId,
    this.name,
    this.email,
  });

  CreatedBy copyWith({
    String? userId,
    String? name,
    String? email,
  }) =>
      CreatedBy(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
      };
}
