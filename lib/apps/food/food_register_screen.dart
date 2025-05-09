import 'package:sdock_fe/apps/food/food_full_app.dart';
import 'package:sdock_fe/apps/food/food_login_screen.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_button.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FoodRegisterScreen extends StatefulWidget {
  @override
  _FoodRegisterScreenState createState() => _FoodRegisterScreenState();
}

class _FoodRegisterScreenState extends State<FoodRegisterScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: MySpacing.nBottom(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            './assets/icons/food-outline.png',
            color: theme.colorScheme.primary,
            width: 36,
            height: 36,
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: MyText.titleLarge("Create account".toUpperCase(),
                color: theme.colorScheme.onBackground,
                fontWeight: 700,
                letterSpacing: 0.5),
          ),
          MySpacing.height(20),
          MyContainer(
            borderRadiusAll: 4,
            paddingAll: 12,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Icon(
                    LucideIcons.user,
                    color: theme.colorScheme.onPrimary,
                    size: 16,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TextFormField(
                      style: MyTextStyle.bodyLarge(
                          letterSpacing: 0.1,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: MyTextStyle.titleSmall(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide.none),
                        isDense: true,
                        contentPadding: EdgeInsets.all(0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                )
              ],
            ),
          ),
          MySpacing.height(20),
          MyContainer(
            borderRadiusAll: 4,
            paddingAll: 12,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Icon(
                      LucideIcons.mail,
                      color: theme.colorScheme.onPrimary,
                      size: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TextFormField(
                      style: MyTextStyle.bodyLarge(
                          letterSpacing: 0.1,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        hintStyle: MyTextStyle.titleSmall(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide.none),
                        isDense: true,
                        contentPadding: EdgeInsets.all(0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                )
              ],
            ),
          ),
          MySpacing.height(20),
          MyContainer(
            borderRadiusAll: 4,
            paddingAll: 12,
            child: Row(
              children: <Widget>[
                MyContainer(
                  paddingAll: 6,
                  color: theme.colorScheme.primary,
                  borderRadiusAll: 4,
                  child: Icon(
                    LucideIcons.lock,
                    color: theme.colorScheme.onPrimary,
                    size: 16,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TextFormField(
                      style: MyTextStyle.bodyLarge(
                          letterSpacing: 0.1,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: MyTextStyle.titleSmall(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide.none),
                        isDense: true,
                        contentPadding: EdgeInsets.all(0),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                )
              ],
            ),
          ),
          MySpacing.height(20),
          MyButton.block(
            elevation: 0,
            borderRadiusAll: 4,
            padding: MySpacing.y(20),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FoodFullApp()));
            },
            child: MyText.bodyMedium("Register".toUpperCase(),
                fontWeight: 600,
                color: theme.colorScheme.onPrimary,
                letterSpacing: 0.5),
          ),
          MySpacing.height(20),
          MyButton.text(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FoodLoginScreen()));
            },
            child: MyText.bodyMedium("I have already an account",
                color: theme.colorScheme.onBackground,
                fontWeight: 500,
                decoration: TextDecoration.underline),
          )
        ],
      ),
    ));
  }
}
