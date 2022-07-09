import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/sharing_file_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';

class ShareFileScreen extends StatelessWidget {
  const ShareFileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SharingFileController>();
    return Obx(() {
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

        body = Container();
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Bagikan File',
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
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: body,
            ),
          ),
        ),
      );
    });
  }
}
