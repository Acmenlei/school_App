import 'package:dio/dio.dart';

class HttpRequest {
  static BaseOptions baseOptions =
      BaseOptions(baseUrl: 'http://192.168.43.249:3002', connectTimeout: 10000);
  static final _dio = Dio(baseOptions);
  static Future request(String url,
      {String method = "get", Map<String, dynamic> parmas}) async {
    Options options = Options(method: method);
    try {
      Response result =
          await _dio.request(url, options: options, queryParameters: parmas);
      return result.data;
    } on DioError catch (err) {
      throw err;
    }
  }
}
