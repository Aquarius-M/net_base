import 'package:dio/dio.dart';
import 'package:format_dio_logger/format_dio_logger.dart';

/// 连接超时时间
const int _connectTimeout = 1000 * 60;

/// 接收超时时间
const int _receiveTimeout = 1000 * 60;

/// 发送超时时间
const int _sendTimeout = 1000 * 60;

/// dio配置项
class RequestConfig {
  RequestConfig({
    required this.baseUrl,
    this.connectTimeout = _connectTimeout,
    this.sendTimeout = _sendTimeout,
    this.receiveTimeout = _receiveTimeout,
    this.interceptors,
    this.useContentTypeInterceptor = true,
    this.validateStatus,
    this.useLog = true,
    this.logger,
  });

  /// 请求基本地址
  final String baseUrl;

  /// 连接服务器超时时间
  final int connectTimeout;

  /// 发送超时时间
  final int sendTimeout;

  /// 两次数据流数据接收的最长间隔时间，注意不是请求的最长接收时间
  final int receiveTimeout;

  /// 拦截器
  final List<Interceptor>? interceptors;

  /// 使用默认的请求头content-type拦截器
  final bool useContentTypeInterceptor;

  /// 定义给定 HTTP 响应状态代码的请求是否成功。为true，请求将被视为成功；否则，视为失败
  ///
  /// 如果该值为空，则使用默认处理，即响应状态码是200为正常返回，即onResponse
  ///
  /// 如果响应状态码非200，则是错误返回，即onError
  ///
  /// 如果该值不为空，且返回值为true，则使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
  ///
  /// 如果该值不为空，且返回值为false，则所有请求皆视为失败，即onError
  ///
  /// e.g.
  /// ```
  ///validateStatus: (status) => true or false
  /// ```
  final ValidateStatus? validateStatus;

  /// 自动开启打印
  final bool useLog;

  /// 打印配置
  final FormatDioLogger? logger;

  RequestConfig copyWith({
    String? baseUrl,
    int? connectTimeout,
    int? sendTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
    bool? useContentTypeInterceptor,
    ValidateStatus? validateStatus,
    bool? useLog,
    FormatDioLogger? logger,
  }) {
    return RequestConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      interceptors: interceptors ?? this.interceptors,
      useContentTypeInterceptor: useContentTypeInterceptor ?? this.useContentTypeInterceptor,
      validateStatus: validateStatus ?? this.validateStatus,
      useLog: useLog ?? this.useLog,
      logger: logger ?? this.logger,
    );
  }
}
