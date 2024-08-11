import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/auth/domain/repositries/auth_repository.dart';
import 'package:littafy/utils/usecase.dart';

class RequestOtpUseCase implements UseCase<Success, Params<String>> {
  final AuthRepository repository;
  RequestOtpUseCase(this.repository);
  @override
  Future<Either<Failure, Success>> call(Params email) async {
    return await repository.requestOtpRepo(email.data);
  }
}
