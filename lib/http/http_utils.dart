import 'dart:io';

import 'package:dio/dio.dart';

class HttpUtils {
  Dio _dio;

  HttpUtils._internal() {
    _dio = new Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
  }

  static HttpUtils instance = HttpUtils._internal();

  factory HttpUtils() => instance;

  Dio get dio => _dio;
}
