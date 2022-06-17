import 'package:get/get.dart';

enum ApiResponseState {
  offline,
  timeout,
  http2xx,
  http403,
}

abstract class ViewController extends GetxController {
  Rxn<ApiResponseState> apiResponseState = Rxn<ApiResponseState>();
  String? errorMessage;
  void checkApResponse(Map<String, dynamic> response) {
    if (response['code'] != null) {
      if (response['code'] == 403) {
        apiResponseState.value = ApiResponseState.http403;
      }
    } else {
      apiResponseState.value = ApiResponseState.http2xx;
    }
  }

  void resetState();
}
