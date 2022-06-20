import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/profile_controller.dart';
import 'package:myevent_android/screen/profile_screen/widget/profile_screen_data_widget.dart';
import 'package:myevent_android/screen/profile_screen/widget/profile_screen_loading_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    Widget profileScreenBody;
    return Obx(
      () {
        if (controller.isLoadProfileData.value) {
          profileScreenBody = ProfileScreenLoadingWidget();
        } else {
          profileScreenBody = ProfileScreenDataWidget();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profil',
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
                child: profileScreenBody,
              ),
            ),
          ),
        );
      },
    );
  }
}
