// To parse this JSON data, do
//
//     final shoppingInviteModel = shoppingInviteModelFromJson(jsonString);

import 'dart:convert';

ShoppingInviteModel shoppingInviteModelFromJson(String str) =>
    ShoppingInviteModel.fromJson(json.decode(str));

String shoppingInviteModelToJson(ShoppingInviteModel data) =>
    json.encode(data.toJson());

class ShoppingInviteModel {
  final String? name;
  final List<String>? accepted;
  final List<String>? declined;
  final List<String>? emails;
  final String? createdBy;
  final String? creatorsName;
  final String id;

  ShoppingInviteModel(
      {this.name,
      this.accepted,
      this.declined,
      this.emails,
      this.createdBy,
      required this.id,
      this.creatorsName});

  ShoppingInviteModel copyWith(
          {String? name,
          List<String>? accepted,
          List<String>? declined,
          List<String>? emails,
          String? createdBy,
          required String id,
          String? creatorsName}) =>
      ShoppingInviteModel(
          name: name ?? this.name,
          accepted: accepted ?? this.accepted,
          declined: declined ?? this.declined,
          emails: emails ?? this.emails,
          createdBy: createdBy ?? this.createdBy,
          id: id,
          creatorsName: creatorsName ?? this.creatorsName);

  factory ShoppingInviteModel.fromJson(Map<String, dynamic> json) =>
      ShoppingInviteModel(
          name: json["name"],
          id: json['id'],
          declined: json['declined'] == null
              ? []
              : List<String>.from(json["accepted"]!.map((x) => x)),
          accepted: json["accepted"] == null
              ? []
              : List<String>.from(json["accepted"]!.map((x) => x)),
          emails: json["emails"] == null
              ? []
              : List<String>.from(json["emails"]!.map((x) => x)),
          createdBy: json["createdBy"],
          creatorsName: json['creators_name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "declined":
            accepted == null ? [] : List<dynamic>.from(accepted!.map((x) => x)),
        "accepted":
            accepted == null ? [] : List<dynamic>.from(accepted!.map((x) => x)),
        "emails":
            emails == null ? [] : List<dynamic>.from(emails!.map((x) => x)),
        "createdBy": createdBy,
        "creators_name": creatorsName
      };
}
