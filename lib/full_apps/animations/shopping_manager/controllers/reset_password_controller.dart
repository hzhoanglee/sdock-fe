import 'package:sdock_fe/full_apps/animations/shopping_manager/views/full_app.dart';
import 'package:sdock_fe/full_apps/animations/shopping_manager/views/register_screen.dart';
import 'package:sdock_fe/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController confirmPasswordTE, passwordTE;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void onInit() {
    confirmPasswordTE = TextEditingController(text: 'password123');
    passwordTE = TextEditingController(text: 'password');
    super.onInit();
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    } else if (!MyStringUtils.validateStringRange(
      text,
    )) {
      return "Password length must between 8 and 20";
    }
    return null;
  }

  String? validateConfirmPassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    } else if (!MyStringUtils.validateStringRange(
      text,
    )) {
      return "Password length must between 8 and 20";
    } else if (passwordTE.text != text) {
      return "Both passwords are not same";
    }
    return null;
  }

  void goToRegisterScreen() {
    Get.off(RegisterScreen());
    // Navigator.of(context, ro
    //     otNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => RegisterScreen(),
    //   ),
    // );
  }

  void resetPassword() {
    if (formKey.currentState!.validate()) {
      Get.off(ShoppingManagerFullApp());
      // Navigator.of(context, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => ShoppingManagerFullApp(),
      //   ),
      // );
    }
  }
}
