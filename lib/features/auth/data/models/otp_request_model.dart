import 'dart:convert';

OtpRequestModel otpRequestModelFromJson(String str) =>
    OtpRequestModel.fromJson(json.decode(str));

String otpRequestModelToJson(OtpRequestModel data) =>
    json.encode(data.toJson());

class OtpRequestModel {
  String message;
  Data data;

  OtpRequestModel({
    required this.message,
    required this.data,
  });

  OtpRequestModel copyWith({
    String? message,
    Data? data,
  }) =>
      OtpRequestModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) =>
      OtpRequestModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String smsStatus;
  String phoneNumber;
  String to;
  String pinId;
  String dataPinId;
  String status;

  Data({
    required this.smsStatus,
    required this.phoneNumber,
    required this.to,
    required this.pinId,
    required this.dataPinId,
    required this.status,
  });

  Data copyWith({
    String? smsStatus,
    String? phoneNumber,
    String? to,
    String? pinId,
    String? dataPinId,
    String? status,
  }) =>
      Data(
        smsStatus: smsStatus ?? this.smsStatus,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        to: to ?? this.to,
        pinId: pinId ?? this.pinId,
        dataPinId: dataPinId ?? this.dataPinId,
        status: status ?? this.status,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        smsStatus: json["smsStatus"],
        phoneNumber: json["phone_number"],
        to: json["to"],
        pinId: json["pinId"],
        dataPinId: json["pin_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "smsStatus": smsStatus,
        "phone_number": phoneNumber,
        "to": to,
        "pinId": pinId,
        "pin_id": dataPinId,
        "status": status,
      };
}
