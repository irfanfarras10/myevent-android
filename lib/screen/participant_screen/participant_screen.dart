import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/participant_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';
import 'package:myevent_android/widget/navigation_drawer_widget.dart';

class ParticipantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ParticipantController>();
    return Obx(
      () {
        Widget body;
        if (controller.isLoading.value) {
          body = LoadingWidget();
        } else {
          if (controller.apiResponseState.value != ApiResponseState.http2xx &&
              controller.apiResponseState.value != ApiResponseState.http401) {
            return HttpErrorWidget(
              errorMessage: controller.errorMessage,
              refreshAction: controller.loadData,
            );
          }

          body = Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60.0,
                        child: TextButton(
                          onPressed: () {
                            controller.menuCategoryIndex.value = 0;
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.people_alt),
                              Text('Registrasi'),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              controller.menuCategoryIndex.value == 0
                                  ? Colors.amber
                                  : Colors.grey.shade400,
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              MyEventColor.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 60.0,
                        child: TextButton(
                          onPressed: controller.eventData!.eventStatus!.id == 2
                              ? null
                              : () {
                                  controller.menuCategoryIndex.value = 1;
                                },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.emoji_people_rounded),
                              Text('Absensi'),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              controller.menuCategoryIndex.value == 1
                                  ? Colors.amber
                                  : Colors.grey.shade400,
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              MyEventColor.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                controller.eventData!.eventStatus!.id == 2 &&
                        controller.menuSubCategoryIndex.value != 1
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ActionChip(
                            label: Text('Terdaftar'),
                            onPressed: () {
                              controller.publishRegistrationIndex.value = 0;
                            },
                            backgroundColor:
                                controller.publishRegistrationIndex.value == 0
                                    ? Colors.amber
                                    : Colors.grey.shade400,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          ActionChip(
                            label: Text('Konfirmasi Pembayaran'),
                            onPressed: () {
                              controller.publishRegistrationIndex.value = 1;
                            },
                            backgroundColor:
                                controller.publishRegistrationIndex.value == 1
                                    ? Colors.amber
                                    : Colors.grey.shade400,
                          ),
                        ],
                      )
                    : Container(),
                !controller.isLoadingParticipantData.value
                    ? controller.participantData!.listParticipant != null &&
                            controller
                                .participantData!.listParticipant!.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('Jogn'),
                                  subtitle: Text(
                                    'jogn@gmail.com',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount: controller
                                  .participantData!.listParticipant!.length,
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Text(
                                'Tidak Ada Data',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                    : Expanded(
                        child: Center(
                          child: LoadingWidget(),
                        ),
                      ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Peserta',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyEventColor.secondaryColor,
              ),
            ),
          ),
          body: body,
          drawer: controller.isLoading.value
              ? null
              : NavigationDrawerWidget(eventData: controller.eventData),
        );
      },
    );
  }
}
