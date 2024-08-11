import 'package:dio/dio.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:toast/toast.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet connection';
          break;
        } else if (dioError.message!.contains("detail")) {
          message = '${dioError.message}';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request : $error';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error;
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;

  static displayError(context, error) {
    final message = DioExceptions.fromDioError(error).toString();

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.unknown) {
      Toast.show(message);
    } else {
      Dialogs.alertBox(context, appName, message);
    }
  }
}
