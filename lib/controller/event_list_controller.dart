import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventListController extends ApiController {
  final isLoading = true.obs;

  List<EventDataList> eventList = [];
  String? authToken;

  @override
  void onInit() {
    getToken();
    loadData();
    super.onInit();
  }

  @override
  void resetState() {
    apiResponseState.value = null;
    eventList.clear();
    isLoading.value = true;
  }

  Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    authToken = 'Bearer ${prefs.getString('myevent.auth.token')}';
  }

  Future<void> loadData() async {
    resetState();
    await apiEvent.getEventDraft().then(
      (response) {
        checkApiResponse(response);
        if (apiResponseState.value != ApiResponseState.http401) {
          isLoading.value = false;
        }
        if (apiResponseState.value == ApiResponseState.http2xx) {
          final eventData = ViewEventApiResponseModel.fromJson(response);
          eventList = eventData.eventDataList!;
        }
      },
    );
  }
}
