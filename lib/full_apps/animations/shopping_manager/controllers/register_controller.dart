import 'package:sdock_fe/full_apps/animations/shopping_manager/views/full_app.dart';
import 'package:sdock_fe/full_apps/animations/shopping_manager/views/login_screen.dart';
import 'package:sdock_fe/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool enable = false;

  @override
  void onInit() {
    // save = false;

    super.onInit();
  }

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter  name";
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    } else if (!MyStringUtils.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    } else if (!MyStringUtils.validateStringRange(text, 6, 10)) {
      return "Password must be between 6 to 10";
    }
    return null;
  }

  void toggle() {
    enable = !enable;
    update();
  }

  void goToLoginScreen() {
    Get.off(LoginScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    // );
  }

  void register() {
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
