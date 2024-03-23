import 'package:dio/dio.dart';

class DioErrorUtil {
  static String handleError(dynamic error) {
    String errorDescription = 'An error happened';

    if (error is DioException) {
      errorDescription = error.message ?? 'An unknown error happened';
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request to server was cancelled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Slow Connection';
          break;
        case DioExceptionType.unknown:
          errorDescription = 'No internet connection';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Failed to receive data from server';
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Failed to send data to server';
          break;
        case DioExceptionType.badCertificate:
          errorDescription = 'Server Bad Certificate';
          break;
        case DioExceptionType.badResponse:
          errorDescription = 'Bad Response';
          break;
        case DioExceptionType.connectionError:
          errorDescription = 'Failed to connect to server';
          break;
      }
    } else {
      errorDescription = error.toString();
    }

    return errorDescription;
  }
}

class LendoException implements Exception {
  LendoException(this.message);
  String message;
}
