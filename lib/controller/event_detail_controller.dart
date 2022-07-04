import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';

class EventDetailController extends ApiController {
  RxBool isLoading = RxBool(true);
  final eventId = int.parse(Get.parameters['id']!);
  ViewEventDetailApiResponseModel? eventData;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void resetState() {
    isLoading.value = true;
  }

  Future<void> loadData() async {
    resetState();
    await apiEvent.getEventDetail(id: eventId).then((response) {
      checkApiResponse(response);
      if (apiResponseState.value != ApiResponseState.http401) {
        isLoading.value = false;
      }
      if (apiResponseState.value == ApiResponseState.http2xx) {
        eventData = ViewEventDetailApiResponseModel.fromJson(response);
      }
    });
  }
}
