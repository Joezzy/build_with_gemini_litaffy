import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';

abstract class AiRepository {
  Future geminiRepo(String prompt);
  Future<Either<Failure, Success>> getArticleRepo(String prompt);
}
