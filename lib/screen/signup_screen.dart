import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Obx(
      () => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20.0,
                  90.0,
                  20.0,
                  0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Akun',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 48.0,
                        color: MyEventColor.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: controller.usernameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
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
                      controller: controller.passwordController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: controller.passwordFocusNode,
                      onChanged: (password) {
                        controller.validatePassword(password);
                      },
                      obscureText: controller.showPassword.value,
                      obscuringCharacter: '●',
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        errorText: controller.passwordErrorMessage.value,
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
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.showPassword.value =
                                !controller.showPassword.value;
                          },
                          icon: controller.showPassword.value
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
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
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 5.5),
                      child: Visibility(
                        visible: controller.errorMessage != null,
                        child: Text(
                          controller.errorMessage ?? '',
                          style: TextStyle(
                            color: Colors.red.shade800,
                            fontSize: 12.0,
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
                        onPressed: controller.isFormValid &&
                                !controller.isLoading.value
                            ? controller.signUp
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
                          controller.isLoading.value
                              ? 'Sedang Mendaftarkan Akun...'
                              : 'Daftar',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: controller.isFormValid
                                ? MyEventColor.secondaryColor
                                : Colors.black26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun ?',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: MyEventColor.secondaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: controller.gotoSignInScreen,
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: MyEventColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
