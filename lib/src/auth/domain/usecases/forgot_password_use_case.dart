import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/auth/domain/repositries/auth_repository.dart';
import 'package:littafy/utils/usecase.dart';

class ForgotPasswordUseCase implements UseCase<Success, Params<String>> {
  final AuthRepository repository;
  ForgotPasswordUseCase(this.repository);
  @override
  Future<Either<Failure, Success>> call(Params email) async {
    return await repository.forgotPasswordRepo(email.data);
  }
}
