import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/contact_person_controller.dart';
import 'package:myevent_android/screen/create_event_contact_person_screen/widget/create_event_contact_person_card_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';

class CreateEventContactPersonScreen extends StatelessWidget {
  final controller = Get.find<ContactPersonController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Widget body;

        if (controller.isLoading.value) {
          body = LoadingWidget();
        } else {
          body = SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: List.generate(
                    controller.contactPersonList.length,
                    (index) {
                      return CreateEventContactPersonCardWidget(index: index);
                    },
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  child: TextButton(
                    onPressed: controller.addContactPerson,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tambahkan Contact Person',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: MyEventColor.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.add,
                          color: MyEventColor.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Pengaturan Contact Person',
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
          body: WillPopScope(
            onWillPop: () async {
              Get.back(result: true);
              return true;
            },
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height,
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
                      onPressed: controller.isAllDataValid
                          ? controller.createContactPerson
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
                        'Simpan Contact Person',
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
