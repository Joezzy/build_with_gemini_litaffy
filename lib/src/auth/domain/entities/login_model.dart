import 'dart:convert';

class LoginModel {
  String email;
  String? password;
  String? firstName;
  String? lastName;
  String authType;
  String? accessToken;

  LoginModel({
    required this.email,
    this.password = "",
    required this.authType,
    this.accessToken = "",
    this.firstName = "",
    this.lastName = "",
  });

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "authType": authType,
        "accessToken": accessToken,
      };
}
