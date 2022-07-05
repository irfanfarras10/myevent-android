import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/event_controller.dart';
import 'package:myevent_android/screen/edit_event_data_screen/widget/edit_event_data_screen_widget.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';

class EditEventDataScreen extends StatelessWidget {
  final controller = Get.find<EventController>(tag: 'edit');
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Widget body;
        if (controller.isLoading.value) {
          body = LoadingWidget();
        } else {
          if (controller.apiResponseState.value != ApiResponseState.http2xx &&
              controller.apiResponseState.value != ApiResponseState.http401 &&
              controller.apiResponseState.value != ApiResponseState.http409 &&
              controller.apiResponseState.value != ApiResponseState.http400) {
            return HttpErrorWidget(
              errorMessage: controller.errorMessage,
              refreshAction: controller.getEventCategory,
            );
          }
          body = EditEventDataScreenWidget();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Event',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyEventColor.secondaryColor,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Get.back(result: true);
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: WillPopScope(
            onWillPop: () async {
              Get.back(result: true);
              return true;
            },
            child: GestureDetector(
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
          ),
          bottomNavigationBar: controller.isLoading.value
              ? null
              : Padding(
                  padding: EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: controller.isDataValid.value
                          ? () async {
                              await controller.updateEvent();
                            }
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
                        'Simpan Data Event',
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
