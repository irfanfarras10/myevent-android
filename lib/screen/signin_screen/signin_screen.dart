import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>(tag: 'signIn');
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
                      'Masuk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 48.0,
                        color: MyEventColor.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Harap masuk untuk melanjutkan',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: MyEventColor.secondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
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
                      controller: controller.passwordController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: controller.passwordFocusNode,
                      onChanged: (password) {
                        controller.validatePassword(password);
                      },
                      obscureText: controller.hidePassword.value,
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
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: controller.hidePassword.value
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
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
                        onPressed: controller.isSignInFormValid &&
                                !controller.isLoading.value
                            ? controller.signIn
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
                              ? 'Sedang Masuk...'
                              : 'Masuk',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: controller.isSignInFormValid
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
                          'Belum punya akun ?',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: MyEventColor.secondaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: controller.gotoSignUpScreen,
                          child: Text(
                            'Daftar',
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
