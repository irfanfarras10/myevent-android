import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/guest_controller.dart';

class CreateGuestScreen extends StatelessWidget {
  const CreateGuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GuestController>();
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Tambah Tamu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyEventColor.secondaryColor,
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onChanged: (String name) {
                        controller.validateName(name);
                      },
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        errorText: controller.nameErrorMessage.value,
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
                      controller: controller.emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String email) {
                        controller.validateEmail(email);
                      },
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
                        errorText: controller.emailErrorMessage.value,
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
                      controller: controller.phoneNumberController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      onChanged: (String number) {
                        controller.validatePhoneNumber(number);
                      },
                      decoration: InputDecoration(
                        labelText: 'Nomor HP',
                        errorText: controller.phoneNumberErrorMessage.value,
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
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
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
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    controller.isAllDataValid ? controller.createGuest : null,
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
                child: Text(
                  'Simpan',
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
