import 'package:dio/dio.dart';
import 'package:format_dio_logger/format_dio_logger.dart';

import 'config/request_config.dart';
import 'interceptors/content_type_interceptors.dart';

/// dio配置
/// version: 1.0
class AppDio with DioMixin implements Dio {
  AppDio({
    required RequestConfig config,
  }) {
    BaseOptions options = BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: Duration(milliseconds: config.connectTimeout),
      sendTimeout: Duration(milliseconds: config.sendTimeout),
      receiveTimeout: Duration(milliseconds: config.receiveTimeout),
      validateStatus: config.validateStatus,
    );
    this.options = options;
    if (config.interceptors?.isNotEmpty ?? false) {
      interceptors.addAll(config.interceptors!);
    }
    // 添加ContentType设置拦截
    if (config.useContentTypeInterceptor) {
      interceptors.add(ContentTypeInterceptor());
    }
    // 是否开启内置打印
    if (config.useLog) {
      interceptors.add(config.logger ?? FormatDioLogger());
    }
    httpClientAdapter = HttpClientAdapter();
  }
}
