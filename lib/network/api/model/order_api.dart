import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class OrderApi {
  OrderApi._();

  static final OrderApi getInstance = OrderApi._();

  Future<AppResponse> getMyOrders(
      {var url, var header, var body, var queryParameters}) async {
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(
          url: url, header: header, queryParameters: queryParameters);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> newSalesOrder({var url, var header, var body}) async {
    try {
      Logger().w(body);
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> getOrderDetails({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> getInvoiceUrlPaymentApi(
      {var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header, queryParameters: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> applyInvoicePaymentApi({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header, queryParameters: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> applyPayment({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> addOrderReview({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> addEmergencyCasesReport(
      {var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> cancelOrder({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      snackError("", "${message["status"]["message"]}");
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> applyCancel({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> editOrder({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()) ?? {});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance
          .handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message ?? {});
    }
  }
}
