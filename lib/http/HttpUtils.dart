import 'package:dio/dio.dart';
import 'package:reading_flutter/http/Api.dart';

class HttpUtils {
  static const CONNECT_TIME = 10000;
  static const RECEIVE_TIME = 3000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static HttpUtils instance;
  static Dio dio;
  BaseOptions options;

  static HttpUtils getInstance() {
    if (instance == null) {
      instance = new HttpUtils();
    }
    return instance;
  }

  HttpUtils() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
        baseUrl: Api.BASE_URL,
        connectTimeout: CONNECT_TIME,
        receiveTimeout: RECEIVE_TIME,
      );
      dio = new Dio(options);
    }
  }

  /// request method
  Future<Map> sendRequest(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';
    /// restful 请求处理
    /// /gysw/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /gysw/search/hist/27
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + data.toString());

    var result;
    try {
      Response response = await dio.request(url,
          data: data, options: new Options(method: method));
      result = response.data;

      /// 打印响应相关信息
      print('响应数据：' + response.toString());
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
    }
    return result;
  }

  /// 清空 dio 对象
  void clear() {
    dio = null;
  }
}
