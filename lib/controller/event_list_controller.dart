import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_list_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';

class EventListController extends ApiController {
  final isLoading = true.obs;
  RxBool isSearchMode = false.obs;

  List<EventDataList> eventList = [];
  RxList<EventDataList> searchEventList = RxList();

  int eventStatus = 1;

  @override
  void resetState() {
    apiResponseState.value = null;
    eventList.clear();
    isLoading.value = true;
  }

  void setSearchMode(bool mode) {
    isSearchMode.value = mode;
  }

  void resetData() {
    searchEventList.value = eventList;
  }

  Future<void> loadData() async {
    resetState();
    if (eventStatus == 1) {
      await apiEvent.getEventDraft().then(
        (response) {
          checkApiResponse(response);
          if (apiResponseState.value != ApiResponseState.http401) {
            isLoading.value = false;
          }
          if (apiResponseState.value == ApiResponseState.http2xx) {
            final eventData = ViewEventListApiResponseModel.fromJson(response);
            eventList = eventData.eventDataList!;
            searchEventList.value = eventList;
          }
        },
      );
    } else if (eventStatus == 2) {
      await apiEvent.getEventPublish().then(
        (response) {
          checkApiResponse(response);
          if (apiResponseState.value != ApiResponseState.http401) {
            isLoading.value = false;
          }
          if (apiResponseState.value == ApiResponseState.http2xx) {
            final eventData = ViewEventListApiResponseModel.fromJson(response);
            eventList = eventData.eventDataList!;
            searchEventList.value = eventList;
          }
        },
      );
    } else if (eventStatus == 5) {
      await apiEvent.getEventCancel().then(
        (response) {
          checkApiResponse(response);
          if (apiResponseState.value != ApiResponseState.http401) {
            isLoading.value = false;
          }
          if (apiResponseState.value == ApiResponseState.http2xx) {
            final eventData = ViewEventListApiResponseModel.fromJson(response);
            eventList = eventData.eventDataList!;
            searchEventList.value = eventList;
          }
        },
      );
    }
  }

  void searchEvent(String keyword) {
    if (keyword.isEmpty) {
      searchEventList.value = eventList;
    } else {
      final searchEventData = eventList
          .where(
            (eventData) => eventData.name!.toLowerCase().contains(keyword),
          )
          .toList();
      searchEventList.value = searchEventData;
    }
  }
}
