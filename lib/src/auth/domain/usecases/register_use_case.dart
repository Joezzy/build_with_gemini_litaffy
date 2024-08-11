import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';
import 'package:littafy/src/auth/domain/repositries/auth_repository.dart';
import 'package:littafy/utils/usecase.dart';

class RegisterUseCase implements UseCase<CurrentUser, Params<CurrentUser>> {
  final AuthRepository authRepository;
  RegisterUseCase(this.authRepository);
  @override
  Future<Either<Failure, CurrentUser>> call(Params param) async {
    return await authRepository.registerRepo(param.data);
  }
}
