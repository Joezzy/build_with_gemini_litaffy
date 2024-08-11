import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/generator/domain/repository/ai_repository.dart';
import 'package:littafy/utils/usecase.dart';

class GeminiUseCase implements UseCase<Success, Params<dynamic>> {
  final AiRepository aiRepository;
  GeminiUseCase(this.aiRepository);

  @override
  Future<Either<Failure, Success>> call(Params data) async {
    return await aiRepository.geminiRepo(data.data);
  }
}
