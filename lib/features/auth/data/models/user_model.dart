// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  // String? password;
  String? picture;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    //required this.password,
    required this.picture,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? picture,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        // password: password ?? this.password,
        picture: picture ?? this.picture,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        // password: json["password"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        // "password": password,
        "picture": picture,
      };
}
