import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/theme/app_theme.dart';
import '../../helpers/theme/custom_theme.dart';
import '../models/device.dart';
import '../models/devicetype.dart';
import '../models/room.dart';

class PairingFormController extends GetxController {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Room room;
  late ScanDevice scan;
  RxList<DeviceType> deviceTypes = RxList<DeviceType>();
  RxList<String> deviceTypeNames = <String>[].obs;
  RxString selectedValue = RxString('');

  @override
  void onInit() {
    super.onInit();
    if (deviceTypeNames.isNotEmpty) {
      selectedValue.value = deviceTypeNames.first;
    }
  }

  void initializeTheme() {
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  void getDeviceTypes() async {
    deviceTypes.value = (await DeviceType.getSwitchTypeDevice())!;
    deviceTypeNames = deviceTypes.map((e) => e.name).toList().obs;
    selectedValue.value = deviceTypeNames.first;
  }
}