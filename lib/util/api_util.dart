import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:myevent_android/config/myevent_config.dart';

final ApiUtil apiUtil = ApiUtil();
final Alice alice = Alice();

class ApiUtil {
  final BaseOptions dioOptions = BaseOptions(
    baseUrl: MyEventConfig.baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    headers: {
      'Content-Type': 'application/json',
      'Accept-Encoding': 'gzip, deflate, br'
    },
  );

  Dio _getDioClient() {
    final Dio dio = Dio(dioOptions);
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
      responseBody = {
        'code': error.response?.statusCode,
        'message': error.response?.data['message'] as String,
      };
    }
    return responseBody;
  }

  Future<Map<String, dynamic>> apiRequestPost(
    String url,
    Map<String, dynamic> requestBody,
  ) async {
    try {
      final Response response =
          await _getDioClient().post(url, data: requestBody);
      return response.data;
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }
}
