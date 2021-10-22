import 'package:dio/dio.dart';
import 'dart:async';

import 'package:logger/logger.dart';


class DioManagerClass {

  DioManagerClass._();
  static final DioManagerClass getInstance = DioManagerClass._();

  Dio? _dio;
  Dio init() {
     _dio =  Dio(
      BaseOptions(
        baseUrl: "https://inbox.ahdtech.com/api/method/",
        connectTimeout: 2000 * 60,
        receiveTimeout: 2000 * 60,
        sendTimeout: 2000 * 60,
        receiveDataWhenStatusError: true,
      ),
    );
    _dio?.interceptors.add(ApiInterceptors());
    return _dio!;
  }

  Future<Response> dioGetMethod({var url, Map<String, dynamic>? header})async{
    return await _dio!.get(url , options:Options(headers: header) );
  }


  Future<Response> dioPostMethod({var url, Map<String, dynamic>? header ,Map<String, dynamic>? body  })async{
    return await _dio!.post(url , options:Options(headers: header),data: body );
  }

  Future<Response> dioUpdateMethod({var url, Map<String, dynamic>? header ,Map<String, dynamic>? body  })async{
    return await _dio!.put(url , options:Options(headers: header),data: body );
  }

  Future<Response> dioDeleteMethod({var url, Map<String, dynamic>? header ,Map<String, dynamic>? body  })async{
    return await _dio!.delete(url , options:Options(headers: header),data: body );
  }
}

class ApiInterceptors extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    super.onRequest(options, handler);
      Logger().d("onRequest : ${options.path}");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
    Logger().d("onResponse : ${response.statusCode}");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
    Logger().d("onError : ${err.message}");
  }
}
