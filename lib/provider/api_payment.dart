import 'package:myevent_android/model/api_request/create_payment_api_request_mode.dart';
import 'package:myevent_android/util/api_util.dart';

final apiPayment = ApiPayment();

class ApiPayment {
  Future<Map<String, dynamic>> createPayment(
      {required String eventId,
      required CreatePaymentApiRequestModel requestBody}) {
    return apiUtil.apiRequestPost(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/payment/create',
      requestBody.toJson(),
    );
  }

  Future<Map<String, dynamic>> updatePayment(
      {required String eventId,
      required String paymentId,
      required CreatePaymentApiRequestModel requestBody}) {
    return apiUtil.apiRequestPut(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/payment/$paymentId',
      requestBody.toJson(),
    );
  }
}
