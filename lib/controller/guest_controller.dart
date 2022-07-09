import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/model/api_response/view_guest_list_api_response_mode.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/provider/api_guest.dart';

class GuestController extends ApiController {
  List<ListGuest> guestData = [];
  RxBool isLoading = RxBool(false);
  int _eventId = int.parse(Get.parameters['id']!);
  ViewEventDetailApiResponseModel? eventData;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void resetState() {
    guestData.clear();
    isLoading.value = true;
  }

  Future<void> loadData() async {
    resetState();
    await apiEvent.getEventDetail(id: _eventId).then((eventResponse) async {
      checkApiResponse(eventResponse);
      if (apiResponseState.value == ApiResponseState.http2xx) {
        eventData = ViewEventDetailApiResponseModel.fromJson(eventResponse);
        await apiGuest.getGuest(id: _eventId).then((guestResponse) async {
          checkApiResponse(guestResponse);
          if (apiResponseState.value == ApiResponseState.http2xx) {
            isLoading.value = false;
            final data = ViewGuestListApiResponseModel.fromJson(guestResponse);
            guestData = data.listGuest!;
          }
        });
      }
    });
  }
}
