import 'package:sdock_fe/full_apps/animations/nft/nft_cache.dart';
import 'package:sdock_fe/full_apps/animations/nft/views/forgot_password_screen.dart';
import 'package:sdock_fe/full_apps/animations/nft/views/full_app.dart';
import 'package:sdock_fe/full_apps/animations/nft/views/register_screen.dart';
import 'package:sdock_fe/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = true;

  @override
  void onInit() {
    // save = false;
    emailController = TextEditingController(text: 'flutkit@coderthemes.com');
    passwordController = TextEditingController(text: 'password');
    fetchData();
    super.onInit();
  }

  fetchData() async {
    await NFTCache.initDummy();
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

  void login() {
    Get.off(NFTFullApp());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => NFTFullApp(),
    //   ),
    // );
  }
}
