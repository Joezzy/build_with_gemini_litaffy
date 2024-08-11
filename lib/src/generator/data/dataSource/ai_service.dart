import 'package:dio/dio.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/network/base_url.dart';

abstract class AiServices {
  Future<Response> getArticleService(String articleUrl);
}

class AiServicesImpl extends AiServices {
  Dio dio;
  AiServicesImpl({required this.dio});

  @override
  Future<Response> getArticleService(String articleUrl) async {
    final url = "$articleBaseUrl/url/article_url";
    print(url);
    try {
      dio
        ..options.connectTimeout = BaseEndpoints.connectionTimeout
        ..options.receiveTimeout = BaseEndpoints.receiveTimeout
        ..options.responseType = ResponseType.json;
      final response = await dio.post(url, data: {"url": articleUrl});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
