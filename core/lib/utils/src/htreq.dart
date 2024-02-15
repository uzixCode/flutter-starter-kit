// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'package:core/core.dart';

class ReqProperties {
  final String path;
  final Methods methods;
  final Object? data;
  final Map<String, dynamic>? queryParameters;
  final Options? options;
  final CancelToken? cancelToken;
  ReqProperties(this.path, this.methods,
      {this.data, this.queryParameters, this.options, this.cancelToken});
}

enum Methods { GET, POST, PUT, DELETE }

class Htreq {
  Future<Response<T>> Function<T>(
      ReqProperties properties, Response<T> response)? middleWareResponse;
  Future<ReqProperties> Function(ReqProperties properties)? middleWareRequest;
  BaseOptions base = BaseOptions(
    validateStatus: (status) => true,
    receiveDataWhenStatusError: true,
  );
  void setBaseUrl(String url) {
    base.baseUrl = url;
  }

  void setMiddleWareResponse<T>(
          Future<Response<T>> Function<T>(
                  ReqProperties properties, Response<T> response)?
              _) =>
      middleWareResponse = _;
  void setMiddleWareRequest(
          Future<ReqProperties> Function(ReqProperties properties)? _) =>
      middleWareRequest = _;

  void setToken([String? token]) async {
    if (token != null) {
      base.headers["Authorization"] = token;
      return;
    }
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // final tok = pref.getString(StorageBox.token);
    // log("Token: $tok");
    // base.headers["Authorization"] = tok;
  }

  Future<Either<Failure, Response<T>>> req<T>(ReqProperties properties,
      {void Function(int, int)? onReceiveProgress}) async {
    final dio = Dio(base);

    try {
      ReqProperties prop = properties;
      if (middleWareRequest != null) {
        prop = await middleWareRequest!(prop);
      }
      Response<T> response;
      switch (prop.methods) {
        case Methods.GET:
          response = await dio.get(prop.path,
              data: prop.data,
              queryParameters: prop.queryParameters,
              cancelToken: prop.cancelToken,
              onReceiveProgress: onReceiveProgress,
              options: prop.options);
          break;
        case Methods.POST:
          response = await dio.post<T>(prop.path,
              data: prop.data,
              queryParameters: prop.queryParameters,
              cancelToken: prop.cancelToken,
              onReceiveProgress: onReceiveProgress,
              options: prop.options);
          break;
        case Methods.PUT:
          response = await dio.put(prop.path,
              data: prop.data,
              queryParameters: prop.queryParameters,
              cancelToken: prop.cancelToken,
              onReceiveProgress: onReceiveProgress,
              options: prop.options);
          break;
        case Methods.DELETE:
          response = await dio.delete(prop.path,
              data: prop.data,
              queryParameters: prop.queryParameters,
              cancelToken: prop.cancelToken,
              options: prop.options);
          break;
      }
      if (middleWareResponse != null) {
        response = await middleWareResponse!(prop, response);
      }

      if (response.statusCode != 200) {
        throw HttpException(response: response);
      }
      log("Response----------------------------");
      log(response.data.toString());
      return Right(response);
    } on HttpException catch (e) {
      return Left(Failure(
          response: BaseResponse(
              status: e.response.statusCode,
              message: "Terjadi kesalahan",
              data: e.response.data ?? "{}")));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          response: BaseResponse(status: 1001, message: "Terjadi kesalahan")));
    }
  }
}
