import 'dart:convert';

VerifiedResponseModel verifiedResponseModelFromJson(String str) =>
    VerifiedResponseModel.fromJson(json.decode(str));

String verifiedResponseModelToJson(VerifiedResponseModel data) =>
    json.encode(data.toJson());

class VerifiedResponseModel {
  String message;
  Data data;

  VerifiedResponseModel({
    required this.message,
    required this.data,
  });

  VerifiedResponseModel copyWith({
    String? message,
    Data? data,
  }) =>
      VerifiedResponseModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory VerifiedResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifiedResponseModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String pinId;
  String verified;
  String msisdn;

  Data({
    required this.pinId,
    required this.verified,
    required this.msisdn,
  });

  Data copyWith({
    String? pinId,
    String? verified,
    String? msisdn,
  }) =>
      Data(
        pinId: pinId ?? this.pinId,
        verified: verified ?? this.verified,
        msisdn: msisdn ?? this.msisdn,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pinId: json["pinId"],
        verified: json["verified"].toString(),
        msisdn: json["msisdn"],
      );

  Map<String, dynamic> toJson() => {
        "pinId": pinId,
        "verified": verified,
        "msisdn": msisdn,
      };
}
