# NetBase
对[Dio](https://pub.dev/packages/dio)进行二次封装，适用于多BaseUrl的项目中使用。

#### 说明

flutter: `3.3.2`

dio: `^5.0.0`

[FormatDioLogger](https://github.com/thintime-X/format_dio_logger.git) 打印工具

## 主要类

- **AppDio** 内置`ContentTypeInterceptor`默认ContentType注入拦截器（Dio5.0开始默认不指定请求的ContentType）与`FormatDioLogger`默认打印工具的Dio。
- **RequestConfig** `AppDio`的配置类，可指定BaseUrl、开启默认打印工具、注入拦截器。
- **BaseRequest** 网络请求工具基类，建议在此实例化Dio对象，同时在onRequestSuccess和onRequestFail中处理接口调用结果，插件中内置`DefaultBaseRequest`默认请求处理工具。
- **BaseRepository** 接口仓库基类，在此获取BaseRequest实例对象，Header请求头，HttpTransformer响应解析工厂，同时也可以在此对不同需求封装。如果项目中有多个`请求基本地址BaseUrl`，可以对应创建Repository接口仓库，指定对应的BaseUrl、Header和响应数据解析，实现`BaseUrl`与`接口仓库`一对一管理。插件中内置DefaultBaseRepository默认仓库基类。
- **HttpTransformer** 响应解析基类，用于对不同响应数据格式的解析。插件内置DefaultHttpTransformer默认解析。

## 基础使用

#### 创建仓库并设置默认配置

继承DefaultBaseRepository创建网络请求仓库，同时可以配置该仓库(可以理解为该BaseUrl)专属的Dio实例(更改getRequest方法)、请求头(更改getHeader方法)、响应数据解析方式(更改getTransformer方法)。DefaultBaseRepository为插件默认仓库基类，继承该基类即使用插件默认的请求配置与解析方式。

```dart
class Repository extends DefaultBaseRepository {
  final RequestConfig _config = RequestConfig(
    baseUrl: "请求基本地址",
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

  Future getTest(Success onSuccess, Fail onFail) async {
    await get(
      url: "/xxx/xxx",
      onSuccess: onSuccess,
      onFail: onFail,
    );
  }
}
```

#### 调用接口

创建该仓库实例，你也可以在仓库内使用factory创建单例，然后调用该接口方法。
```dart
Repository repository = Repository();
repository.successRequest(
    (data) {},
    (code, msg) {},
);
```
