import 'package:sdock_fe/full_apps/animations/nft/views/register_screen.dart';
import 'package:sdock_fe/full_apps/animations/nft/views/reset_password_screen.dart';
import 'package:sdock_fe/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void onInit() {
    emailController = TextEditingController(text: 'flutkit@coderthemes.com');
    super.onInit();
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    } else if (!MyStringUtils.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  void forgotPassword() {
    if (formKey.currentState!.validate()) {
      Get.off(ResetPasswordScreen());
      // Navigator.of(context, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => ResetPasswordScreen(),
      //   ),
      // );
    }
  }

  void goToRegisterScreen() {
    Get.off(RegisterScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => RegisterScreen(),
    //   ),
    // );
  }
}
