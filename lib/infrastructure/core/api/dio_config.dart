import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'endpoints_config.dart';

class DioConfig {
  static final DioConfig _singleton = DioConfig._internal();

  factory DioConfig() {
    return _singleton;
  }
  DioConfig._internal();

  final Dio dio = Dio();

  int retryCount = 0;

  void initInterceptors() {
    dio.options.headers = {"accept": "application/json"};

    dio.interceptors.add(
      QueuedInterceptorsWrapper(onRequest: (options, handler) async {
        return handler.next(options);
      }, onResponse: (response, handler) async {
        return handler.next(response);
      }, onError: (e, handler) async {
        Logger().f(
            '------------ ERROR STATUS ${e.response?.statusCode}  ${e.requestOptions.uri.toString().replaceAll(APIConfig.URL, '').trim()}------------');

        return handler.next(e);
      }),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }
}
