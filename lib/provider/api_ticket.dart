import 'package:myevent_android/model/api_request/create_ticket_api_request_model.dart';
import 'package:myevent_android/util/api_util.dart';

final apiTicket = ApiTicket();

class ApiTicket {
  Future<Map<String, dynamic>> createTicket(
      {required String eventId,
      required CreateTicketApiRequestModel requestBody}) {
    return apiUtil.apiRequestPost(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/ticket/create',
      requestBody.toJson(),
    );
  }
}
