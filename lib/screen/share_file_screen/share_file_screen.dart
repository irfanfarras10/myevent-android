import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/sharing_file_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';
import 'package:myevent_android/widget/navigation_drawer_widget.dart';

class ShareFileScreen extends StatelessWidget {
  const ShareFileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SharingFileController>();
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

          body = Column(
            children: [
              TextFormField(
                //   controller: controller.nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                // onChanged: (String name) {
                //   controller.validateName(name);
                // },
                decoration: InputDecoration(
                  labelText: 'Judul',
                  // errorText: controller.nameErrorMessage.value,
                  fillColor: MyEventColor.primaryColor,
                  labelStyle: TextStyle(
                    color: MyEventColor.secondaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                //   controller: controller.nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                // onChanged: (String name) {
                //   controller.validateName(name);
                // },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Upload File',
                  // errorText: controller.nameErrorMessage.value,
                  fillColor: MyEventColor.primaryColor,
                  labelStyle: TextStyle(
                    color: MyEventColor.secondaryColor,
                  ),

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                //   controller: controller.nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                // onChanged: (String name) {
                //   controller.validateName(name);
                // },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Link',
                  // errorText: controller.nameErrorMessage.value,
                  fillColor: MyEventColor.primaryColor,
                  labelStyle: TextStyle(
                    color: MyEventColor.secondaryColor,
                  ),

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                //   controller: controller.nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                // onChanged: (String name) {
                //   controller.validateName(name);
                // },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  // errorText: controller.nameErrorMessage.value,
                  fillColor: MyEventColor.primaryColor,
                  labelStyle: TextStyle(
                    color: MyEventColor.secondaryColor,
                  ),

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyEventColor.primaryColor,
                    ),
                  ),
                ),
                maxLines: 10,
              ),
            ],
          );
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
          drawer: !controller.isLoading.value
              ? NavigationDrawerWidget(eventData: controller.eventData)
              : null,
          bottomNavigationBar: !controller.isLoading.value
              ? Container(
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
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
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
                        'Bagikan',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: MyEventColor.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
