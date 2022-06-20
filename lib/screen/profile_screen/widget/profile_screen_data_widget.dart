import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/profile_controller.dart';

class ProfileScreenDataWidget extends StatelessWidget {
  const ProfileScreenDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Obx(
      () => Column(
        children: [
          TextFormField(
            controller: controller.usernameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            enabled: controller.editMode.value,
            focusNode: controller.usernameFocusNode,
            onChanged: (String username) {
              controller.validateUsername(username);
            },
            decoration: InputDecoration(
              labelText: 'Username',
              errorText: controller.usernameErrorMessage.value,
              fillColor: MyEventColor.primaryColor,
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
            height: 30.0,
          ),
          TextFormField(
            controller: controller.organizerNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            enabled: controller.editMode.value,
            focusNode: controller.organizerNameFocusNode,
            onChanged: (String organizerName) {
              controller.validateOrganizerName(organizerName);
            },
            decoration: InputDecoration(
              labelText: 'Nama Event Organizer',
              errorText: controller.organizerNameErrorMessage.value,
              fillColor: MyEventColor.primaryColor,
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
            height: 30.0,
          ),
          TextFormField(
            controller: controller.emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            enabled: controller.editMode.value,
            focusNode: controller.emailFocusNode,
            onChanged: (String email) {
              controller.validateEmail(email);
            },
            decoration: InputDecoration(
              labelText: 'E-Mail',
              errorText: controller.emailErrorMessage.value,
              fillColor: MyEventColor.primaryColor,
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
            height: 30.0,
          ),
          TextFormField(
            controller: controller.phoneNumberController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            enabled: controller.editMode.value,
            focusNode: controller.phoneNumberFocusNode,
            onChanged: (String phoneNumber) {
              controller.validatePhoneNumber(phoneNumber);
            },
            decoration: InputDecoration(
              labelText: 'Nomor HP',
              errorText: controller.phoneNumberErrorMessage.value,
              fillColor: MyEventColor.primaryColor,
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
            height: 30.0,
          ),
          SizedBox(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: controller.onPressedEditButton(),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.editMode.value ? 'Simpan Data' : 'Ubah Data',
                    style: TextStyle(
                      fontSize: 17.0,
                      // color: controller.isSignUpFormValid
                      //     ? MyEventColor.secondaryColor
                      //     : Colors.black26,
                      color: MyEventColor.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    controller.editMode.value ? Icons.save : Icons.edit,
                    color: MyEventColor.secondaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: controller.logout,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    return Colors.red;
                  },
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Keluar Akun',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
