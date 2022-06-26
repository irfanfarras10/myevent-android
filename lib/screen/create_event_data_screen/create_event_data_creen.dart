import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/event_controller.dart';
import 'package:myevent_android/screen/create_event_data_screen/widget/create_event_data_screen_widget.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';

class CreateEventDataScreen extends StatelessWidget {
  const CreateEventDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();
    return Obx(
      () {
        // print(
        //     'isBannerImageUploaded.value ${controller.isBannerImageUploaded.value}');
        // print('isNameValid.value ${controller.isNameValid.value}');
        // print(
        //     'isDescriptionValid.value ${controller.isDescriptionValid.value}');
        // print(
        //     'isDateTimeEventValid.value  ${controller.isDateTimeEventValid.value}');
        // print('isLocationValid.value ${controller.isLocationValid.value}');
        // print('venue != null ${controller.venue != null}');
        // print(
        //     'eventVenueCategoryId != null ${controller.eventVenueCategoryId != null}');
        // print('eventCategoryId != null ${controller.eventCategoryId != null}');
        // print('isCategoryValid.value ${controller.isCategoryValid.value}');

        Widget body;
        if (controller.isLoadingEventCategoryData.value) {
          body = LoadingWidget();
        } else {
          if (controller.apiResponseState.value != ApiResponseState.http2xx &&
              controller.apiResponseState.value != ApiResponseState.http401 &&
              controller.apiResponseState.value != ApiResponseState.http409) {
            return HttpErrorWidget(
              errorMessage: controller.errorMessage,
              refreshAction: controller.getEventCategory,
            );
          }
          body = CreateEventDataScreenWidget();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Membuat Event',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyEventColor.secondaryColor,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (controller.locationController.text.isEmpty ||
                  controller.venue!.isEmpty) {
                controller.locationController.text = '';
              }
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: body,
            ),
          ),
          bottomNavigationBar: controller.isLoadingEventCategoryData.value
              ? null
              : Padding(
                  padding: EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: controller.isDataValid.value
                          ? controller.createEvent
                          : null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.amber.shade300;
                            }
                            return Colors.amber;
                          },
                        ),
                      ),
                      child: Text(
                        'Atur Tiket',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: MyEventColor.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
