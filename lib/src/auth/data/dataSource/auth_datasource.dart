// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:dio/dio.dart';
// import 'package:littafy/constant/constants.dart';
// import 'package:littafy/network/base_url.dart';
// import 'package:littafy/network/dio_client.dart';
// import 'package:littafy/src/auth/domain/entities/login_model.dart';
// import 'package:littafy/src/auth/domain/entities/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// abstract class AuthDataSource {
//   Future<Response> login(LoginModel loginModel);
//   Future<Response> register(CurrentUser currentUser);
//   Future<Response> updateInfo(dynamic currentUser);
//   Future<Response> forgotPassword(dynamic email);
//   Future<Response> resetPassword(String username, String password);
//   Future<Response> requestOtp(dynamic email);
//   Future<Response> changePassword(dynamic otp,);
// }
//
// class AuthDataSourceImpl implements AuthDataSource {
//   DioClient dioClient;
//   AuthDataSourceImpl({required this.dioClient});
//
//   @override
//   Future<Response> forgotPassword(email) async {
//     try {
//       final Response response = await dioClient.post(
//         BaseEndpoints.baseUrl,
//         accessToken: loginToken,
//         data: email,
//       );
//
//       print("response == ${response}");
//       // print(response);
//
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   @override
//   Future<Response> login(LoginModel loginModel) async {
//     try {
//       final Response response = await dioClient.post(
//         BaseEndpoints.baseUrl,
//         accessToken: loginToken,
//         data: loginModel.toRawJson(),
//       );
//
//       log(json.encode(response.data));
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   @override
//   Future<Response> register(CurrentUser CurrentUser) async {
//     // TODO: implement register
//     try {
//       final Response response = await dioClient.post(
//         BaseEndpoints.baseUrl,
//         accessToken: loginToken,
//         data: CurrentUser.toJson(),
//       );
//       log(json.encode(response.data));
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   @override
//   Future<Response> updateInfo(dynamic payload) async {
//     try {
//       final Response response = await dioClient.put(
//         BaseEndpoints.baseUrl,
//         accessToken: loginToken,
//         data: payload,
//       );
//       log(json.encode(response.data));
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   @override
//   Future<Response> requestOtp(email) async {
//     // TODO: implement register
//     try {
//       final Response response = await dioClient.post(
//         BaseEndpoints.baseUrl,
//         accessToken: loginToken,
//         data: email,
//       );
//       log(json.encode(response.data));
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//
//   @override
//   Future<Response> changePassword(otp) async {
//     // TODO: implement register
//     try {
//       final Response response = await dioClient.put(
//         BaseEndpoints.baseUrl,
//         accessToken: loginToken,
//         data: otp,
//       );
//       log(json.encode(response.data));
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   @override
//   Future<Response> resetPassword(String username, String password) {
//     // TODO: implement resetPassword
//     throw UnimplementedError();
//   }
//
//
//
// }
