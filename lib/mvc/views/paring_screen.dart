import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:sdock_fe/mvc/views/pairing_form_screen.dart';

import '../../loading_effect.dart';
import '../models/device.dart';
import '../models/room.dart';

class SwitchParingScreen extends StatefulWidget {
  const SwitchParingScreen({Key? key}) : super(key: key);

  @override
  _SwitchParingScreenState createState() => _SwitchParingScreenState();
}

class _SwitchParingScreenState extends State<SwitchParingScreen> {
  // room ID and room name
  Room room = Get.arguments as Room;
  late RxList<ScanDevice> _scannedDeviceList = <ScanDevice>[].obs;
  List<ScanDevice> get scannedDeviceList => _scannedDeviceList;
  late ThemeData theme;
  late CustomTheme customTheme;
  bool showLoading = true, uiLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchParingDevices();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  Future<void> _fetchParingDevices() async {
    try {
      _scannedDeviceList.clear();
      List<ScanDevice>? paringDevices = await ScanDevice.getParingDevice();
      _scannedDeviceList.addAll(paringDevices!);
      uiLoading = false;
    } catch (e) {
      // Handle the error
      if (kDebugMode) {
        print('Error fetching paring devices: $e');
      }
    }
  }


  Widget _buildSingleEvent(ScanDevice scan, {bool old = false}) {
    return MyContainer.bordered(
      paddingAll: 16,
      borderRadiusAll: 16,
      child: GestureDetector(
        onTap: () {
          Get.to(() => PairingFormScreen(),
              arguments: [room, scan]);
        },
        child: Row(
          children: [
            MyContainer(
              width: 56,
              padding: MySpacing.y(12),
              borderRadiusAll: 4,
              bordered: true,
              border: Border.all(color: customTheme.medicarePrimary),
              color: old
                  ? Colors.transparent
                  : customTheme.medicarePrimary.withAlpha(60),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText.bodyMedium(
                      DateFormat('dd').format(DateTime.now()).toString(),
                      fontWeight: 700,
                      color: customTheme.medicarePrimary,
                    ),
                    MyText.bodySmall(
                      DateFormat('MMM').format(DateTime.now()).toString(),
                      fontWeight: 600,
                      color: customTheme.medicarePrimary,
                    ),
                  ],
                ),
              ),
            ),
            MySpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodySmall(
                    scan.ip,
                    fontWeight: 600,
                  ),
                  MySpacing.height(4),
                  MyText.bodySmall(
                    scan.deviceId,
                    fontSize: 10,
                  ),
                  MySpacing.height(4),
                  MyText.bodySmall(
                    "Unconfirmed",
                    fontSize: 10,
                  ),
                ],
              ),
            ),
            MySpacing.width(16),
            MyContainer.rounded(
              paddingAll: 4,
              color: customTheme.card,
              child: Icon(
                old ? Icons.two_k_plus_rounded : Icons.two_k_plus_rounded,
                size: 16,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ],
        ),
      )
    );
  }

  List<Widget> _buildScannedList() {
    List<Widget> list = [];

    for (int i = 0; i < scannedDeviceList.length; i++) {
      list.add(_buildSingleEvent(scannedDeviceList[i]));

      if (i + 1 < scannedDeviceList.length) list.add(MySpacing.height(16));
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText.bodyLarge(
          'Adding for Room: ${room.title}',
          fontWeight: 700,
        ),
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          Icon(
            Icons.more_horiz,
            color: theme.colorScheme.onBackground,
            size: 24,
          ),
          MySpacing.width(24)
        ],
      ),
      body: ListView(
        padding: MySpacing.fromLTRB(24, 8, 24, 24),
        children: [
          MyText.titleMedium(
            'Switches',
            letterSpacing: 0.5,
            fontWeight: 700,
          ),
          MySpacing.height(16),
          Obx(() => Column(
            children: _buildScannedList(),
          ))
        ],
      ),
    );
  }
}
