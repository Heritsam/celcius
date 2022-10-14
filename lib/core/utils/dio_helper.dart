import 'dart:io';

import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

class DioHelper {
  final Dio dio;

  const DioHelper(this.dio);

  dynamic get(
    dynamic url, {
    Map<String, dynamic> headers = const <String, dynamic>{},
  }) async {
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            ...headers,
          },
        ),
      );

      return _handleReturnResponse(response);
    } on SocketException {
      throw ServerException('No Internet Connection');
    }
  }

  dynamic post(
    dynamic url, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            ...headers,
          },
        ),
        data: {},
      );

      return _handleReturnResponse(response);
    } on SocketException {
      throw ServerException('No Internet Connection');
    }
  }

  dynamic _handleReturnResponse(Response response) {
    print('HttpHelper: ${response.statusCode}');

    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      default:
        final body = response.data;
        throw ServerException(
          body['message']?.toString() ?? body.toString(),
          body['result'] ?? null,
        );
    }
  }
}
