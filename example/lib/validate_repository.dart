import 'dart:developer';

import 'package:net_base/net_base.dart';

/// 使用标准REST风格仓库
///
/// 使用默认的请求头content-type拦截器和输出处理
///
/// validateStatus: (status) => true
class ValidateRepository extends DefaultBaseRepository {
  final RequestConfig _config = RequestConfig(
    baseUrl: "https://run.mocky.io/v3",
    validateStatus: (status) => true,
    useLog: true,
  );

  @override
  BaseRequest getRequest() {
    return DefaultBaseRequest(_config);
  }

  @override
  Map<String, dynamic> getHeader() {
    return {"Header": "header value"};
  }

  @override
  HttpTransformer getTransformer() {
    return DefaultHttpTransformer.getInstance();
  }

  Future successRequest() async {
    await get(
      url: "/2943e324-75f3-4471-a5a4-ba8886b755e6",
      onSuccess: (data) {
        log("成功输出 $data");
      },
      onFail: (code, msg) {
        log("错误输出 $code $msg");
      },
    );
  }

  Future errorRequest() async {
    await get(
      url: "/f4c30d34-fb3a-4e22-9f01-bcb7c445f9e5",
      onSuccess: (data) {
        log("成功输出 $data");
      },
      onFail: (code, msg) {
        log("错误输出 $code $msg");
      },
    );
  }
}
