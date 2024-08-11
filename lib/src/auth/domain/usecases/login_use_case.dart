import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/auth/domain/entities/login_model.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';
import 'package:littafy/src/auth/domain/repositries/auth_repository.dart';
import 'package:littafy/utils/usecase.dart';

class LoginUseCase implements UseCase<CurrentUser, Params<LoginModel>> {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  @override
  Future<Either<Failure, CurrentUser>> call(Params loginModel) async {
    return await repository.loginRepo(loginModel.data);
  }
}
