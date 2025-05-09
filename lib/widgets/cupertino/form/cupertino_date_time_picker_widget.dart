/*
* File : Cupertino Date & Time Picker
* Version : 1.0.0
* */

import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CupertinoDateTimePickerWidget extends StatefulWidget {
  @override
  _CupertinoDateTimePickerWidgetState createState() =>
      _CupertinoDateTimePickerWidgetState();
}

class _CupertinoDateTimePickerWidgetState
    extends State<CupertinoDateTimePickerWidget> {
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
    return GetBuilder(
      tag: 'cupertino_date_time_picker_widget',
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  LucideIcons.chevronLeft,
                  size: 20,
                ),
              ),
              title: MyText.titleMedium("Date & Time", fontWeight: 600),
            ),
            body: Container(
                color: theme.colorScheme.background,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    onDateTimeChanged: (dateTime) {})));
      },
    );
  }
}
