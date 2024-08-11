import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/core/errors/dio_exception.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/generator/data/dataSource/ai_service.dart';
import 'package:littafy/src/generator/domain/repository/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  AiServices aiServices;
  AiRepositoryImpl({required this.aiServices});

  @override
  Future geminiRepo(String prompt) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: geminiKey);


    // const prompt = 'Write a story about a magic backpack.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    print(response.text);

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Success>> getArticleRepo(String url) async {
    try {
      final result = await aiServices.getArticleService(url);
      log(result.data.toString());
      return Right(Success(result.data["content"]));
    } on DioException catch (e) {
      // log(e.response.toString());
      // log(e.response!.data);
      return Left(Failure(DioExceptions.fromDioError(e).toString()));
    }
  }
}
