import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/generator/domain/repository/ai_repository.dart';
import 'package:littafy/utils/usecase.dart';

class GetArticleUseCase implements UseCase<Success, Params<dynamic>> {
  final AiRepository aiRepository;
  GetArticleUseCase(this.aiRepository);

  @override
  Future<Either<Failure, Success>> call(Params orderParam) async {
    return await aiRepository.getArticleRepo(orderParam.data);
  }
}
