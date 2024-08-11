import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';
import 'package:littafy/src/auth/domain/repositries/auth_repository.dart';
import 'package:littafy/utils/usecase.dart';

class GoogleLoginUseCase implements UseCase<CurrentUser, NoParams> {
  final AuthRepository repository;
  GoogleLoginUseCase(this.repository);
  @override
  Future<Either<Failure, CurrentUser>> call(NoParams param) async {
    return await repository.googleLoginRepo();
  }
}
