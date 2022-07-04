import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_list_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

class EventListController extends ApiController {
  final isLoading = true.obs;
  RxBool isSearchMode = false.obs;

  List<EventDataList> eventList = [];
  RxList<EventDataList> searchEventList = RxList();
  String? authToken;

  @override
  void onInit() {
    loadData();
    getToken();
    super.onInit();
  }

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
          final eventData = ViewEventListApiResponseModel.fromJson(response);
          eventList = eventData.eventDataList!;
          searchEventList.value = eventList;
        }
      },
    );
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

  Future<String> parseLocation(
    EventStatus eventVenueCategory,
    String location,
  ) async {
    if (eventVenueCategory.id == 1) {
      final coordinate = location.split('|');
      final lat = double.parse(coordinate[0]);
      final lon = double.parse(coordinate[1]);
      final address = await placemarkFromCoordinates(lat, lon);
      return address[0].street!;
    } else {
      return 'Online Event';
    }
  }
}
