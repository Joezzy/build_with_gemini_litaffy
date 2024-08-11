import 'dart:async';

// import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final InternetConnectionChecker internetConnectionChecker;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.internetConnectionChecker,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    var listerner;
    final responseCompleter = Completer<Response>();
    // streamSubscription = internetConnectionChecker.onConnectivityChanged.listen(
    //       (connectivityResult) async {
    //     // We're connected either to WiFi or mobile data
    //     if (connectivityResult != ConnectivityResult.none) {
    //       // Ensure that only one retry happens per connectivity change by cancelling the listener
    //       streamSubscription!.cancel();
    //       // Copy & paste the failed request's data into the new request
    //       responseCompleter.complete(
    //           dio.request(
    //             requestOptions.path,
    //             cancelToken: requestOptions.cancelToken,
    //             data: requestOptions.data,
    //             onReceiveProgress: requestOptions.onReceiveProgress,
    //             onSendProgress: requestOptions.onSendProgress,
    //             queryParameters: requestOptions.queryParameters,
    //             options: Options(
    //                 method: requestOptions.method,
    //                 headers: requestOptions.headers,
    //                 sendTimeout: requestOptions.sendTimeout,
    //                 receiveTimeout: requestOptions.receiveTimeout
    //             ),
    //
    //           )
    //       );
    //
    //     }
    //   },
    // );

    listerner = internetConnectionChecker.onStatusChange.listen((status) async {
      if (status == InternetConnectionStatus.connected) {
        responseCompleter.complete(dio.request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
          options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
              sendTimeout: requestOptions.sendTimeout,
              receiveTimeout: requestOptions.receiveTimeout),
        ));
      }
    });
    return responseCompleter.future;
  }
}
