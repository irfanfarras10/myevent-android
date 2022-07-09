import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/guest_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';
import 'package:myevent_android/widget/navigation_drawer_widget.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final controller = Get.find<GuestController>();
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

          body = SingleChildScrollView(
            child: controller.guestData.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '0 Tamu Undangan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5,
                            color: MyEventColor.secondaryColor,
                          ),
                        ),
                        Text(
                          'Event tidak mengundang tamu',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5,
                            color: MyEventColor.secondaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          '${controller.guestData.length} Tamu Undangan',
                          style: TextStyle(
                            fontSize: 16.5,
                            color: MyEventColor.secondaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              controller.guestData[index].name!,
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.guestData[index].email!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(), // us
                                Expanded(
                                  child: Text(
                                    controller.guestData[index].phoneNumber!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: controller.guestData.length,
                      )
                    ],
                  ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Tamu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyEventColor.secondaryColor,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_comment_rounded),
              )
            ],
          ),
          body: body,
          drawer: controller.isLoading.value
              ? null
              : NavigationDrawerWidget(eventData: controller.eventData),
          floatingActionButton: controller.isLoading.value
              ? null
              : FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                  ),
                ),
        );
      },
    );
  }
}
