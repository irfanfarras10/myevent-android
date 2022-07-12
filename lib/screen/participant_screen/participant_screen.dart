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

          body = GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: RefreshIndicator(
              onRefresh: controller.loadParticipantData,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(15.0),
                children: [
                  controller.eventData!.eventStatus!.id == 2 &&
                          controller.menuSubCategoryIndex.value != 1
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ActionChip(
                              label: Text('Terdaftar'),
                              onPressed: () {
                                controller.publishRegistrationIndex.value = 0;
                                controller.loadParticipantData();
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
                                controller.loadParticipantData();
                              },
                              backgroundColor:
                                  controller.publishRegistrationIndex.value == 1
                                      ? Colors.amber
                                      : Colors.grey.shade400,
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Visibility(
                    visible: !controller.isLoadingParticipantData.value,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari berdasarkan nama peserta',
                        hintStyle: TextStyle(
                          color: MyEventColor.secondaryColor,
                        ),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                      onChanged: (keyword) {
                        controller.searchEvent(keyword);
                      },
                    ),
                  ),
                  SizedBox(height: 15.0),
                  !controller.isLoadingParticipantData.value
                      ? controller.dataList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.dataList.length} Peserta',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.5,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          controller.dataList[index].name!),
                                      subtitle: Text(
                                        controller.dataList[index].email!,
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      leading: Icon(Icons.person),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                  itemCount: controller.dataList.length,
                                ),
                              ],
                            )
                          : Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                color: Colors.grey.shade200,
                              ),
                              child: Text(
                                'Tidak Ada Data Peserta',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                      : Center(
                          child: LoadingWidget(),
                        )
                ],
              ),
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
