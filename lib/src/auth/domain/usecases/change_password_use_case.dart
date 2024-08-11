import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/auth/domain/repositries/auth_repository.dart';
import 'package:littafy/utils/usecase.dart';

class ChangePasswordUseCase implements UseCase<Success, Params<dynamic>> {
  final AuthRepository repository;
  ChangePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(Params data) async {
    return await repository.changePasswordRepo(data.data);
  }
}
