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
    apiEvent.getEventDetail(id: eventId).then((response) {
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

  String calculateTicketTotal() {
    int ticketQuotaTotal = 0;
    eventData!.ticket!.forEach((ticketData) {
      ticketQuotaTotal += ticketData.quotaTotal!;
    });
    return ticketQuotaTotal.toString();
  }

  Widget? getBottomButton() {
    Widget? bottomButton;
    if (!isLoading.value && eventData!.eventStatus!.id == 1) {
      bottomButton = Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
              color: Colors.black26,
            ),
          ],
        ),
        child: SizedBox(
          height: 60.0,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.amber.shade300;
                  }
                  return Colors.amber;
                },
              ),
            ),
            child: Text(
              'Publish Event',
              style: TextStyle(
                fontSize: 17.0,
                color: MyEventColor.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    return bottomButton;
  }

  void deleteEvent() async {
    Get.defaultDialog(
      title: 'Hapus Event',
      content: Text(
        'Apakah Anda ingin menghapus event?',
        textAlign: TextAlign.center,
      ),
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: MyEventColor.secondaryColor,
      barrierDismissible: false,
      onConfirm: () async {
        Get.back();
        Get.dialog(
          AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 15.0),
                Text('Menghapus data event...'),
              ],
            ),
          ),
          barrierDismissible: false,
        );

        await apiEvent.deleteEvent(id: eventId).then(
          (response) {
            checkApiResponse(response);
            if (apiResponseState.value == ApiResponseState.http2xx) {
              Get.back();
              Get.defaultDialog(
                titleStyle: TextStyle(
                  fontSize: 0.0,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Event berhasil di hapus',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: MyEventColor.secondaryColor,
                      ),
                    ),
                    Icon(
                      Icons.check,
                      size: 50.0,
                      color: Colors.green,
                    ),
                  ],
                ),
                textConfirm: 'OK',
                confirmTextColor: MyEventColor.secondaryColor,
                barrierDismissible: false,
                onConfirm: () {
                  Get.back();
                  Get.back(result: true);
                },
              );
            } else if (apiResponseState.value != ApiResponseState.http401) {
              Get.back();
              Get.defaultDialog(
                titleStyle: TextStyle(
                  fontSize: 0.0,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Event gagal di hapus',
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
                  Get.back();
                  Get.back(result: true);
                },
              );
            }
          },
        );
      },
    );
  }
}
