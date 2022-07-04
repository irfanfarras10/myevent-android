import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void openLocation() async {
    final coordinate = eventData!.venue!.split('|');
    final lat = double.parse(coordinate[0]);
    final lon = double.parse(coordinate[1]);
    final googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    try {
      await launch(googleMapUrl);
    } catch (e) {
      Get.defaultDialog(
        titleStyle: TextStyle(
          fontSize: 0.0,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tidak dapat membuka Google Map',
              style: TextStyle(
                fontSize: 15.0,
                color: MyEventColor.secondaryColor,
              ),
            ),
            Icon(
              Icons.close,
              size: 50.0,
              color: Colors.red,
            ),
          ],
        ),
        textConfirm: 'OK',
        confirmTextColor: MyEventColor.secondaryColor,
        barrierDismissible: false,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
