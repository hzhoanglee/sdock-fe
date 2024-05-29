import 'dart:convert';

import 'package:sdock_fe/mvc/rental_service_cache.dart';
import 'package:sdock_fe/mvc/services/api_constants.dart';
import 'package:sdock_fe/mvc/views/forgot_password_screen.dart';
import 'package:sdock_fe/mvc/views/full_app.dart';
import 'package:sdock_fe/mvc/views/register_screen.dart';
import 'package:sdock_fe/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdock_fe/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/utils/info_controller.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool enable = false;

  @override
  void onInit() {
    // save = false;
    emailController = TextEditingController(text: 'hoangle2@hzme.net');
    passwordController = TextEditingController(text: '28062003');
    fetchData();
    super.onInit();
  }

  fetchData() async {
    await RentalServiceCache.initDummy();
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

  void goToRegisterScreen() {
    Get.off(RegisterScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => RegisterScreen(),
    //   ),
    // );
  }

  void goToForgotPasswordScreen() {
    Get.off(ForgotPasswordScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => ForgotPasswordScreen(),
    //   ),
    // );
  }

  void login() async {
    String endpoint = '${ApiConstants.baseUrl}/auth/login';
    Map<String, dynamic> body = {
      'identity': emailController.text,
      'password': passwordController.text,
    };

    try {
      final response = await GetConnect().post(endpoint, body);

      if (response.statusCode == 200) {
        Info.success('Login success', context: Get.context);
        String token = response.body['data'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        Get.off(() => const RentalServiceFullApp());
      } else {
        // Handle the error case
        print('Error: ${response.statusCode} - ${response.body['message']}');
        Info.error('Login failed: ${response.body['message']}', context: Get.context);
      }
    } catch (e) {
      // Handle the exception case
      print('Exception: $e');
    }
  }
}
