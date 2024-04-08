import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:term_project/helpers/storage.dart';

class ApiCaller {
  //static const baseUrl = 'https://dummyjson.com/products';
  static final _dio = Dio(BaseOptions(responseType: ResponseType.plain));

  Future<String> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get('$endpoint', queryParameters: params);
      debugPrint('Status code: ${response.statusCode}');
      print('test');
      debugPrint(response.data.toString());
      return response.data.toString();
    } on DioException catch (e) {
      print('err');
      var msg = e.response?.data.toString();
      debugPrint(msg);
      throw Exception(msg);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String> post(String endpoint,
      {required Map<String, dynamic>? params}) async {
    try {
      // var token = await Storage().read(Storage.keyToken);
      // _dio.options.headers["Authorization"] = "Bearer $token";
      final response =
          await _dio.post('http://localhost:3000/$endpoint', data: params);

      debugPrint(response.data.toString());
      return response.data.toString();
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
