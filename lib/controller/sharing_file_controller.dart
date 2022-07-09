import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';

class SharingFileController extends ApiController {
  ViewEventDetailApiResponseModel? eventData;
  RxBool isLoading = RxBool(true);
  final _eventId = int.parse(Get.parameters['id']!);

  @override
  void resetState() {
    isLoading.value = true;
  }

  Future<void> loadData() async {
    resetState();
    apiEvent.getEventDetail(id: _eventId).then((response) {
      checkApiResponse(response);
      if (apiResponseState.value == ApiResponseState.http2xx) {
        eventData = ViewEventDetailApiResponseModel.fromJson(response);
        isLoading.value = false;
      }
    });
  }
}
