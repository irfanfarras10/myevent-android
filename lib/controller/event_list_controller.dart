import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/provider/api_event.dart';

class EventListController extends ApiController {
  final isLoading = true.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void resetState() {
    // TODO: implement resetState
  }

  Future<void> getData() async {
    await apiEvent.getEventDraft().then(
      (response) {
        checkApiResponse(response);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          isLoading.value = false;
        }
      },
    );
  }
}
