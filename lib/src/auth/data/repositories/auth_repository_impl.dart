import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:littafy/core/errors/dio_exception.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/auth/data/dataSource/auth_service.dart';
import 'package:littafy/src/auth/domain/entities/login_model.dart';
import 'package:littafy/src/auth/domain/entities/register_response_model.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';
import 'package:littafy/src/auth/domain/repositries/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  AuthRepositoryImpl({required this.authService});

  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future<Either<Failure, CurrentUser>> loginRepo(LoginModel loginModel) async {
    try {
      final result = await authService.login(loginModel);
      return Right(result!);
    } catch (e) {
      print(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> googleLoginRepo() async {
    try {
      final res = await googleSignIn.signIn();
      var accessToken = "";
      var names = res!.displayName!.split(" ");

      await res!.authentication.then((googleKey) {
        accessToken = googleKey.accessToken.toString();
        print("access-token: ${googleKey.accessToken}");
        print("Id-Token : ${googleKey.idToken}");
      }).catchError((err) {
        print('inner error');
      });

      final payload = LoginModel(
          email: res!.email,
          firstName: names[0],
          lastName: names[1],
          authType: "google",
          accessToken: accessToken);

      final result = await authService.login(payload);
      return Right(result!);
      //refresh
//googleSignIn.UserModel.clearAuthCache()
// method followed by googleSignIn.signInSilently()
    } on DioException catch (e) {
      print(e.toString());
      return Left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (error) {
      print(error.toString());
      return Left(Failure("Couldn't login"));
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> registerRepo(
      CurrentUser currentUser) async {
    try {
      await authService.register(currentUser);
      return Right(currentUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> forgotPasswordRepo(String email) async {
    try {
      final result = await authService.forgotPassword(email);
      print("status: ${result}");
      // final res = RegisterResponseModel.fromRawJson(json.encode(result.data["m"]));
      return Right(Success(result));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> resetPasswordRepo() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Success>> requestOtpRepo(String email) async {
    try {
      final result = await authService.requestOtp({"email": email});
      final res =
          RegisterResponseModel.fromRawJson(json.encode(result.data["data"]));
      return Right(Success(res.otpCode!));
    } on DioError catch (e) {
      return Left(Failure(DioExceptions.fromDioError(e).toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> changePasswordRepo(payload) async {
    // String accountCreationToken=otpData["accountCreationToken"];
    // String otp=otpData["otp"];
    try {
      final result = await authService.changePassword(payload);
      print("status: ${result.statusCode}");
      return Right(Success("Setup completed"));
    } on DioError catch (e) {
      return Left(Failure(DioExceptions.fromDioError(e).toString()));
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> updateInfoRepo(dynamic payload) async {
    try {
      String? userPref;

      final res = await authService.updateInfo(payload);
      print("status: ${res.statusCode}");
      // final res = RegisterResponseModel.fromRawJson(json.encode(result.data["data"]));
      CurrentUser userData =
          CurrentUser.fromJson(json.encode(res.data["data"]));
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? getUser = pref.getString('UserModel');

      if (getUser == null) {
        userPref = pref.getString('not_UserModel');
      } else {
        userPref = getUser;
      }

      Map<String, dynamic> userMap =
          jsonDecode(userPref!) as Map<String, dynamic>;
      CurrentUser userModel = CurrentUser.fromJson(json.encode(userMap));
      // userModel.user = userData;
      pref.setString("UserModel", userModel.toJson());
      return Right(userData!);
    } on DioError catch (e) {
      print(e);
      return Left(Failure(DioExceptions.fromDioError(e).toString()));
    }
  }
}
