import 'dart:convert';

class RegisterResponseModel {
  String? otpCode;
  String? accountCreationToken;
  String? link;

  RegisterResponseModel({
    this.otpCode,
    this.accountCreationToken,
    this.link,
  });

  factory RegisterResponseModel.fromRawJson(String str) =>
      RegisterResponseModel.fromJson(json.decode(str));

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        otpCode: json["otpCode"],
        accountCreationToken: json["accountCreationToken"],
        link: json["link"],
      );
}
