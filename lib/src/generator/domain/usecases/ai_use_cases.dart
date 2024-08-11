import 'package:littafy/src/generator/domain/usecases/gemini_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/get_article_use_case.dart';

class AiUseCases {
  final GetArticleUseCase getArticleUseCase;
  final GeminiUseCase geminiUseCase;

  AiUseCases({required this.getArticleUseCase, required this.geminiUseCase});
}
