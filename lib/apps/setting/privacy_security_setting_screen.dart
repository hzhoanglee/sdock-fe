/*
* File : Privacy Setting
* Version : 1.0.0
* */

import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PrivacySecuritySettingScreen extends StatefulWidget {
  @override
  _PrivacySecuritySettingScreenState createState() =>
      _PrivacySecuritySettingScreenState();
}

class _PrivacySecuritySettingScreenState
    extends State<PrivacySecuritySettingScreen> {
  bool _email = true;
  bool _birthDate = true;
  bool _message = false;
  bool _facebook = true;
  bool _twitter = true;
  bool _instagram = true;
  bool _google = false;
  bool _gDrive = true;
  bool _photos = false;

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
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              LucideIcons.chevronLeft,
              size: 20,
              color: theme.colorScheme.onBackground,
            ),
          ),
          centerTitle: true,
          title: MyText.titleMedium("Privacy & Security", fontWeight: 600),
        ),
        backgroundColor: theme.colorScheme.background,
        body: ListView(
          padding: MySpacing.nTop(20),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 4),
              child: MyText.bodySmall("Privacy".toUpperCase(),
                  fontWeight: 600,
                  color: theme.colorScheme.onBackground.withAlpha(200),
                  letterSpacing: 0.3),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: MyText.titleSmall(
                        "Show my email address on my profile",
                        fontWeight: 600,
                        letterSpacing: 0)),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  value: _email,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: theme.colorScheme.primary,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MyText.titleSmall("Show my birth date on my profile",
                      fontWeight: 600, letterSpacing: 0),
                ),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      _birthDate = value;
                    });
                  },
                  value: _birthDate,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: theme.colorScheme.primary,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MyText.titleSmall("Allow user to message you directly",
                      fontWeight: 600, letterSpacing: 0),
                ),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      _message = value;
                    });
                  },
                  value: _message,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: theme.colorScheme.primary,
                )
              ],
            ),
            Divider(
              color: theme.dividerColor,
              thickness: 0.5,
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 4),
              child: MyText.bodySmall("Social Accounts".toUpperCase(),
                  fontWeight: 600,
                  color: theme.colorScheme.onBackground.withAlpha(200),
                  letterSpacing: 0.3),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MyText.titleSmall("Facebook",
                      fontWeight: 600, letterSpacing: 0),
                ),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      _facebook = value;
                    });
                  },
                  value: _facebook,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: theme.colorScheme.primary,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MyText.titleSmall("Twitter",
                      fontWeight: 600, letterSpacing: 0),
                ),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      _twitter = value;
                    });
                  },
                  value: _twitter,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: theme.colorScheme.primary,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MyText.titleSmall("Instagram",
                      fontWeight: 600, letterSpacing: 0),
                ),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      _instagram = value;
                    });
                  },
                  value: _instagram,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: theme.colorScheme.primary,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MyText.titleSmall("Google+",
                      fontWeight: 600, letterSpacing: 0),
                ),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      _google = value;
                    });
                  },
                  value: _google,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: theme.colorScheme.primary,
                )
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: MyText.bodySmall("Connected apps".toUpperCase(),
                  fontWeight: 600,
                  color: theme.colorScheme.onBackground.withAlpha(200),
                  letterSpacing: 0.3),
            ),
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 4),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MyText.titleMedium("G Drive",
                              fontWeight: 600, letterSpacing: 0),
                          Container(
                              margin: EdgeInsets.only(top: 4),
                              child: MyText.bodySmall(
                                  "This is may backup your files",
                                  fontWeight: 500,
                                  letterSpacing: 0,
                                  height: 1)),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: theme.dividerColor,
                      thickness: 1.2,
                    ),
                    Switch(
                      onChanged: (bool value) {
                        setState(() {
                          _gDrive = value;
                        });
                      },
                      value: _gDrive,
                      activeColor: theme.colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 4),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyText.titleMedium("Photos",
                              fontWeight: 600, letterSpacing: 0),
                          Container(
                              margin: EdgeInsets.only(top: 2),
                              child: MyText.bodySmall(
                                  "This is may backup your photos",
                                  fontWeight: 500,
                                  letterSpacing: 0,
                                  height: 1)),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: theme.dividerColor,
                      thickness: 1.2,
                    ),
                    Switch(
                      onChanged: (bool value) {
                        setState(() {
                          _photos = value;
                        });
                      },
                      value: _photos,
                      activeColor: theme.colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
