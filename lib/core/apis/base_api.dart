import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../views/widgets/utils.dart';

export 'dart:io';

export 'package:dio/dio.dart';

export '../models/error_util.dart';
export 'local_storage.dart';

class BaseAPI {
  String get baseUrl => "https://api.yelp.com/v3/";
  Dio dio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        sendTimeout: const Duration(seconds: 50),
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
        contentType: 'application/json',
        validateStatus: (int? s) => s! < 500,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (req, handler) {
          req.headers['Authorization'] = 'Bearer ${Utils.yelpToken}';
          return handler.next(req);
        },
        onResponse: (res, handler) {
          return handler.next(res);
        },
      ),
    );

    return dio;
  }

  log(dynamic data) {
    Logger l = Logger();
    l.d(data);
  }

  String error(dynamic data) {
    if (data['error'] == null) {
      return data['message'] ?? 'An error occurred';
    } else {
      return data['error']['description'];
    }
  }
}
