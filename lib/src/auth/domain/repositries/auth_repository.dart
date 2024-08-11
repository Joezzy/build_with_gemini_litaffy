import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/auth/domain/entities/login_model.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, CurrentUser>> loginRepo(LoginModel loginModel);
  Future<Either<Failure, CurrentUser>> googleLoginRepo();
  Future<Either<Failure, CurrentUser>> registerRepo(CurrentUser currentUser);
  Future<Either<Failure, CurrentUser>> updateInfoRepo(dynamic payload);
  Future<Either<Failure, Success>> forgotPasswordRepo(String email);
  Future<Either<Failure, Success>> resetPasswordRepo();
  Future<Either<Failure, Success>> requestOtpRepo(String email);
  Future<Either<Failure, Success>> changePasswordRepo(dynamic otp);
}
