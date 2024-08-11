import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:littafy/network/base_url.dart';
import 'package:littafy/network/dio_connectivity_request_retry.dart';
import 'package:littafy/network/retry_interceptor.dart';

class DioClient {
  // dio instance
  Dio dio = Dio();
  InternetConnectionChecker connectivity = InternetConnectionChecker();
  // injecting dio instance

  DioClient() {
    // final request = DioConnectivityRequest(
    //   connectivity: connectivity,
    //   dio: dio,
    // );
    //
    // final retryInterceptor = OnRetryConnection(
    //   request: request,
    // );

    dio
      ..options.connectTimeout = BaseEndpoints.connectionTimeout
      ..options.receiveTimeout = BaseEndpoints.receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.headers['Authorization'] = ""
      ..interceptors.add(
        RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            internetConnectionChecker: connectivity,
          ),
        ),
      )
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] =
          accessToken == null ? "No-Token" : "Bearer $accessToken";

      //  dio
      // ..options.baseUrl = BaseEndpoints.baseUrl
      // ..options.connectTimeout = BaseEndpoints.connectionTimeout
      // ..options.receiveTimeout = BaseEndpoints.receiveTimeout
      // ..options.responseType = ResponseType.json
      //
      // ..options.headers['Authorization'] =accessToken==null?"No-Token":"Bearer $accessToken";

      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? accessToken,
  }) async {
    dio.options.headers['Authorization'] =
        accessToken == null ? "No-Token" : "Bearer $accessToken";
    //        // ..options.baseUrl = BaseEndpoints.baseUrl
    // ..options.connectTimeout = BaseEndpoints.connectionTimeout;
    // ..options.receiveTimeout = BaseEndpoints.receiveTimeout
    // ..options.responseType = ResponseType.json
    // ..options.headers['accept'] ="application/json"

    try {
      final Response response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] =
          accessToken == null ? "No-Token" : "Bearer $accessToken";
      // dio
      //   ..options.baseUrl = BaseEndpoints.baseUrl
      //   ..options.connectTimeout = BaseEndpoints.connectionTimeout
      //   ..options.receiveTimeout = BaseEndpoints.receiveTimeout
      //   ..options.responseType = ResponseType.json
      //   ..options.headers['Authorization'] =accessToken==null?"No-Token":"Bearer $accessToken";
      final Response response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Patch:-----------------------------------------------------------------------
  Future<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] =
          accessToken == null ? "No-Token" : "Bearer $accessToken";
      // dio
      //   ..options.baseUrl = BaseEndpoints.baseUrl
      //   ..options.connectTimeout = BaseEndpoints.connectionTimeout
      //   ..options.receiveTimeout = BaseEndpoints.receiveTimeout
      //   ..options.responseType = ResponseType.json
      //   ..options.headers['Authorization'] =accessToken==null?"No-Token":"Bearer $accessToken";
      //

      final Response response = await dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? accessToken,
  }) async {
    try {
      dio
        ..options.connectTimeout = BaseEndpoints.connectionTimeout
        ..options.receiveTimeout = BaseEndpoints.receiveTimeout
        ..options.responseType = ResponseType.json
        ..options.headers['Authorization'] =
            accessToken == null ? "No-Token" : "Bearer $accessToken";
      final Response response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
