import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';

class EventListController extends ApiController {
  final isLoading = true.obs;

  List<EventDataList> eventList = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void resetState() {
    eventList.clear();
    isLoading.value = true;
  }

  Future<void> getData() async {
    resetState();
    await apiEvent.getEventDraft().then(
      (response) {
        checkApiResponse(response);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          final eventData = ViewEventApiResponseModel.fromJson(response);
          eventList = eventData.eventDataList!;
          isLoading.value = false;
        }
      },
    );
  }
}
