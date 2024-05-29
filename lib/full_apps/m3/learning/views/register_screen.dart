import 'package:sdock_fe/full_apps/m3/learning/controllers/register_controller.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/theme/constant.dart';
import 'package:sdock_fe/helpers/widgets/my_button.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/helpers/widgets/my_text_style.dart';
import 'package:sdock_fe/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late ThemeData theme;
  late RegisterController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.learningTheme;
    controller = RegisterController();
    outlineInputBorder = OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(Constant.textFieldRadius.medium)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: controller,
        tag: 'register_controller',
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return Scaffold(
      body: ListView(
        padding:
            MySpacing.fromLTRB(20, MySpacing.safeAreaTop(context) + 36, 20, 20),
        children: [
          MyText.displaySmall(
            'Hello! \nSignup to Get Started',
            fontWeight: 700,
            color: theme.colorScheme.primary,
          ),
          MySpacing.height(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyContainer.bordered(
                border: Border.all(
                    color: controller.selectedRole == 1
                        ? theme.colorScheme.primary
                        : Colors.transparent),
                /*color: controller.selectedRole == 1
                    ? theme.colorScheme.primary.withAlpha(40)
                    : theme.colorScheme.primaryContainer,*/
                padding: MySpacing.xy(28, 20),
                borderRadiusAll: Constant.containerRadius.medium,
                onTap: () {
                  controller.select(1);
                },
                child: Column(
                  children: [
                    Image(
                      height: 64,
                      width: 64,
                      image: AssetImage(Images.teacher),
                    ),
                    MySpacing.height(12),
                    MyText.bodySmall(
                      'Teacher',
                      fontWeight: 600,
                      color: controller.selectedRole == 1
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onBackground,
                    ),
                  ],
                ),
              ),
              MyContainer.bordered(
                border: Border.all(
                    color: controller.selectedRole == 2
                        ? theme.colorScheme.primary
                        : Colors.transparent),
                /*color: controller.selectedRole == 2
                    ? theme.colorScheme.primary.withAlpha(40)
                    : theme.colorScheme.primaryContainer,*/
                padding: MySpacing.xy(28, 20),
                borderRadiusAll: Constant.containerRadius.medium,
                onTap: () {
                  controller.select(2);
                },
                child: Column(
                  children: [
                    Image(
                      height: 64,
                      width: 64,
                      image: AssetImage(Images.student),
                    ),
                    MySpacing.height(12),
                    MyText.bodySmall(
                      'Student',
                      fontWeight: 600,
                      color: controller.selectedRole == 2
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onBackground,
                    ),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(40),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  style: MyTextStyle.bodyMedium(),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      fillColor: theme.colorScheme.primaryContainer,
                      prefixIcon: Icon(
                        LucideIcons.user,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Name",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      hintStyle: MyTextStyle.bodyMedium(),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.nameTE,
                  validator: controller.validateName,
                  cursorColor: theme.colorScheme.onBackground,
                ),
                MySpacing.height(20),
                TextFormField(
                  style: MyTextStyle.bodyMedium(),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      fillColor: theme.colorScheme.primaryContainer,
                      prefixIcon: Icon(
                        LucideIcons.mail,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Email Address",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      hintStyle: MyTextStyle.bodyMedium(),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.emailTE,
                  validator: controller.validateEmail,
                  cursorColor: theme.colorScheme.onBackground,
                ),
                MySpacing.height(20),
                TextFormField(
                  style: MyTextStyle.bodyMedium(),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      fillColor: theme.colorScheme.primaryContainer,
                      prefixIcon: Icon(
                        LucideIcons.lock,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Password",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      hintStyle: MyTextStyle.bodyMedium(),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.passwordTE,
                  validator: controller.validatePassword,
                  cursorColor: theme.colorScheme.onBackground,
                ),
              ],
            ),
          ),
          MySpacing.height(20),
          MyButton.block(
            elevation: 0,
            borderRadiusAll: Constant.buttonRadius.large,
            onPressed: () {
              controller.register();
            },
            padding: MySpacing.y(20),
            splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            backgroundColor: theme.colorScheme.primary,
            child: MyText.labelLarge(
              "Sign Up",
              color: theme.colorScheme.onPrimary,
            ),
          ),
          MySpacing.height(16),
          Center(
            child: MyButton.text(
              onPressed: () {
                controller.goToLogInScreen();
              },
              padding: MySpacing.zero,
              splashColor: theme.colorScheme.primary.withAlpha(40),
              child: MyText.bodySmall("Already have an account?",
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
