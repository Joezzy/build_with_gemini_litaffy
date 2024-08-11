import 'dart:io';

import 'package:dio/dio.dart';
import 'package:littafy/network/dio_connectivity_request_retry.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        final response =
            await requestRetrier.scheduleRequestRetry(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // return e;
        return handler.next(err);
      }
    }
    // Let the error "pass through" if it's not the error we're looking for
    handler.reject(err);
  }

  bool _shouldRetry(DioException err) {
    // return err.type == DioErrorType.other &&  err.error is SocketException;
    //
    return err.type == DioExceptionType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }
}
