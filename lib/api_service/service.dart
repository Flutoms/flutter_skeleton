import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:midlr/database/database.dart';
import 'package:midlr/dependency/app_config/app_config.dart';
import 'package:midlr/dependency/get_it.dart';
import 'package:midlr/utils/helpers.dart';

abstract class ServiceHelpers {
  Future<Response?> post({
    required String endPointUrl,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  });

  Future<void> postFormData(
      {required String endPointUrl, required FormData formData});

  Future<Response?> get({
    required String endPointUrl,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  });

  Future<Response?> put({
    required String endPointUrl,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  });

  Future<Response?> patch({
    required String endPointUrl,
    required Map<String, dynamic> body,
  });

  Future<Response?> delete(
      {required String endPointUrl, Map<String, dynamic>? query});
}

String baseUrl = getItInstance<AppConfig>().baseUrl;

void showLog(dynamic data) {
  return getItInstance<AppConfig>().isDev
      ? globaLog('Response', jsonEncode(data))
      : '';
}

class ServiceHelpersImp extends ServiceHelpers {
  Dio dio;
  TempDatabaseImpl tempDatabaseImpl;

  BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10), // 10 seconds
      receiveTimeout: const Duration(seconds: 10) // 10 seconds
      );

  ServiceHelpersImp({required this.dio, required this.tempDatabaseImpl});

  @override
  Future<Response?> post(
      {required String endPointUrl,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    dio = Dio(options);

    try {
      Response response = await dio.post(
        endPointUrl,
        data: jsonEncode(body),
        queryParameters: query,
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          },
        ),
      );

      showLog(response.data);
      return response;
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectionTimeout) {
        globalToast('Connection timed out');
      }
      return null;
    }
  }

  @override
  Future<Response?> postFormData(
      {required String endPointUrl, required FormData formData}) async {
    dio = Dio(options);

    try {
      Response response = await dio.post(
        '$baseUrl$endPointUrl',
        data: formData,
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          },
        ),
      );
      showLog(response.data);
      return response;
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectionTimeout) {
        globalToast('Connection timed out');
      }

    }
  }

  @override
  Future<Response?> put(
      {required String endPointUrl,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    dio = Dio(options);

    try {
      Response response = await dio.put(endPointUrl,
          queryParameters: query,
          data: jsonEncode(body),
          options: Options(validateStatus: (_) => true, headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          }));

      showLog(response.data);
      return response;
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectionTimeout) {
        globalToast('Connection timed out');
      }
      return null;
    }
  }

  @override
  Future<Response?> patch(
      {required String endPointUrl, required Map<String, dynamic> body}) async {
    dio = Dio(options);

    try {
      Response response = await dio.patch(endPointUrl,
          data: jsonEncode(body),
          options: Options(validateStatus: (_) => true, headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          }));
      showLog(response.data);
      return response;
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectionTimeout) {
        globalToast('Connection timed out');
      }
      return null;
    }
  }

  @override
  Future<Response?> delete(
      {required String endPointUrl, Map<String, dynamic>? query}) async {
    dio = Dio(options);

    try {
      Response response = await dio.delete(endPointUrl,
          queryParameters: query,
          options: Options(validateStatus: (_) => true, headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          }));
      showLog(response.data);
      return response;
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectionTimeout) {
        globalToast('Connection timed out');
      }
      return null;
    }
  }

  @override
  Future<Response?> get(
      {required String endPointUrl,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    dio = Dio(options);

    try {
      Response response = await dio.get(endPointUrl,
          queryParameters: query,
          options: Options(validateStatus: (_) => true, headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          }));
      showLog(response.data);
      return response;
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectionTimeout) {
        globalToast('Connection timed out');
      }
      return null;
    }
  }
}
