import 'package:sdock_fe/mvc/views/full_app.dart';
import 'package:sdock_fe/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController confirmPasswordTE, passwordTE;
  GlobalKey<FormState> formKey = GlobalKey();
  bool enablePass = false;
  bool enableConfirmPass = false;

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

  void togglePassword() {
    enablePass = !enablePass;
    update();
  }

  void toggleConfirmPassword() {
    enableConfirmPass = !enableConfirmPass;
    update();
  }

  void resetPassword() {
    if (formKey.currentState!.validate()) {
      Get.off(RentalServiceFullApp());
      // Navigator.of(context, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => RentalServiceFullApp(),
      //   ),
      // );
    }
  }
}
