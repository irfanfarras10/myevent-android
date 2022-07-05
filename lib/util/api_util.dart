import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ApiUtil apiUtil = ApiUtil();
final Alice alice = Alice();

class ApiUtil {
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('myevent.auth.token');
  }

  Future<Dio> _getDioClient() async {
    final dio = Dio();
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    dio.options.headers['Authorization'] = 'Bearer ${await _getAuthToken()}';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    dio.interceptors.add(alice.getDioInterceptor());
    return dio;
  }

  Future<Map<String, dynamic>> _handleDioError(DioError error) async {
    Map<String, dynamic> responseBody;

    if (error.type == DioErrorType.connectTimeout) {
      responseBody = {'code': 2000, 'message': 'Connect Timeout'};
    } else if (error.type == DioErrorType.receiveTimeout) {
      responseBody = {'code': 3000, 'message': 'Connect Timeout'};
    } else if (error.type == DioErrorType.other) {
      responseBody = {'code': 5000, 'message': 'Internet Offline'};
    } else {
      if (error.response!.data['message'] != null) {
        responseBody = {
          'code': error.response?.statusCode,
          'message': error.response!.data['message'],
        };
      } else {
        responseBody = {
          'code': error.response?.statusCode,
        };
      }
    }
    return responseBody;
  }

  Future<Map<String, dynamic>> apiRequestPost(
    String url,
    Map<String, dynamic> requestBody,
  ) async {
    try {
      final httpClient = await _getDioClient();
      final response = await httpClient.post(url, data: requestBody);
      return response.data;
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }

  Future<Map<String, dynamic>> apiRequestPut(
    String url,
    Map<String, dynamic> requestBody,
  ) async {
    try {
      final httpClient = await _getDioClient();
      final response = await httpClient.put(url, data: requestBody);
      return response.data;
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }

  Future<Map<String, dynamic>> apiRequestGet(String url) async {
    try {
      final httpClient = await _getDioClient();
      final response = await httpClient.get(url);
      return response.data;
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }

  Future<Map<String, dynamic>> apiRequestDelete(String url) async {
    try {
      final httpClient = await _getDioClient();
      final response = await httpClient.delete(url);
      return response.data;
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }

  Future<Map<String, dynamic>> apiRequestMultipartPost({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      final formData = FormData.fromMap(data);
      final httpClient = await _getDioClient();
      final response = await httpClient.post(url, data: formData);
      return response.data;
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }

  Future<Map<String, dynamic>> apiRequestMultipartPut({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      final formData = FormData.fromMap(data);
      final httpClient = await _getDioClient();
      final response = await httpClient.put(url, data: formData);
      return response.data;
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }
}
