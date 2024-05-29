import 'dart:async';

import 'package:sdock_fe/mvc/controllers/single_room_controller.dart';
import 'package:sdock_fe/mvc/models/car.dart';
import 'package:sdock_fe/helpers/extensions/extensions.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/theme/constant.dart';
import 'package:sdock_fe/helpers/widgets/my_button.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sdock_fe/mvc/models/device.dart';
import 'package:sdock_fe/mvc/models/devicestatus.dart';
import 'package:sdock_fe/mvc/models/room.dart';
import 'package:sdock_fe/mvc/views/paring_screen.dart';
import 'package:sdock_fe/mvc/views/switch_log_screen.dart';


class SingleRoomScreen extends StatefulWidget {
  final Room room;


  const SingleRoomScreen({Key? key, required this.room}) : super(key: key);

  @override
  _SingleRoomScreenState createState() => _SingleRoomScreenState();
}

class _SingleRoomScreenState extends State<SingleRoomScreen> {
  late ThemeData theme;
  late SingleRoomController controller;
  var sensors = <Device>[].obs;
  var switches = <Device>[].obs;
  Timer? _timer;


  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = SingleRoomController(widget.room);
    controller.onInit();
    // _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => getSensorValues());
  }
  void getSensorValues() {
    for (var sensor in controller.sensors) {
      sensor.getValueDevice(sensor.id);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            controller.goBack();
          },
          child: const Icon(
            LucideIcons.chevronLeft,
          ),
        ),
        title: MyText.titleMedium(
          "Details",
          fontWeight: 700,
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                Get.to(const SwitchParingScreen(), arguments: widget.room);
              },
              child: Icon(
                controller.fav ? Icons.favorite : Icons.favorite_outline,
                color: theme.colorScheme.secondary,
              )),
          MySpacing.width(20),
        ],
      ),
      body: Padding(
        padding: MySpacing.x(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image(),
                  MySpacing.height(20),
                  MyText.titleMedium(
                    controller.room.title,
                    fontWeight: 700,
                  ),
                  MySpacing.height(4),
                  location(),
                  MySpacing.height(4),
                  MyText.titleSmall(
                      "\$${controller.room.title} /hour"),
                  MySpacing.height(20),
                  carSpecsTitle(),
                  MySpacing.height(20),
                  Obx(() => sensorsList()),
                  MySpacing.height(20),
                  switchHeading(),
                  MySpacing.height(20),
                  Obx(() => switchList()),
                  MySpacing.height(20),

                  // MyText.bodyMedium(
                  //   "Car Info",
                  //   fontWeight: 700,
                  // ),
                  // MySpacing.height(20),
                  // carInfo(),
                ],
              ),
            ),
            MyButton.block(
              onPressed: () {
                controller.goToPaymentScreen();
              },
              elevation: 0,
              padding: MySpacing.y(20),
              borderRadiusAll: Constant.buttonRadius.small,
              child: MyText.labelLarge(
                "Book Now",
                fontWeight: 700,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            MySpacing.height(20),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return MyContainer(
      paddingAll: 0,
      borderRadiusAll: Constant.containerRadius.xs,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image(
        image: NetworkImage(controller.room.image),
        fit: BoxFit.cover,
        height: 150,
      ),
    );
  }

  Widget location() {
    return Row(
      children: [
        Icon(
          LucideIcons.mapPin,
          size: 12,
        ),
        MySpacing.width(8),
        MyText.bodyMedium(
          controller.room.title,
          xMuted: true,
        ),
      ],
    );
  }

  Widget carSpecsTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText.bodyMedium(
          "Car Specs",
          fontWeight: 700,
        ),
        MyText.bodySmall(
          "See More",
          fontWeight: 600,
          color: theme.colorScheme.primary,
        ),
      ],
    );
  }

  Widget sensorsList() {
    List<Widget> list = [];
    for (int i = 0; i < controller.sensors.length; i++) {
      list.add(sensorsWidget(controller.sensors[i]));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget sensorsWidget(Device sensor) {
    return SensorWidget(sensor: sensor);
  }

  Widget switchHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText.bodyMedium(
          "Switches",
          fontWeight: 700,
        ),
        MyText.bodySmall(
          "See More",
          fontWeight: 600,
          color: theme.colorScheme.primary,
        ),
      ],
    );
  }

  Widget switchList() {
    List<Widget> list = [];
    for (int i = 0; i < controller.switches.length; i++) {
      list.add(switchesWidget(controller.switches[i]));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget switchesWidget(Device sw) {
    return SwitchWidget(device: sw);
  }


  Widget carInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                MySpacing.width(8),
                MyText.bodySmall(
                  "${controller.room.title} Passengers",
                  fontWeight: 600,
                ),
              ],
            ),
            MySpacing.height(4),
            Row(
              children: [
                Icon(
                  Icons.ac_unit,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                MySpacing.width(8),
                MyText.bodySmall(
                  "Air Conditioning",
                  fontWeight: 600,
                ),
              ],
            ),
            MySpacing.height(4),
            Row(
              children: [
                Icon(
                  Icons.speed,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                MySpacing.width(8),
                MyText.bodySmall(
                  "Unlimited Milieage",
                  fontWeight: 600,
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.sensor_door,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                MySpacing.width(8),
                MyText.bodySmall(
                  "${controller.room.title} Doors",
                  fontWeight: 600,
                ),
              ],
            ),
            MySpacing.height(4),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                MySpacing.width(8),
                MyText.bodySmall(
                  controller.room.title,
                  fontWeight: 600,
                ),
              ],
            ),
            MySpacing.height(4),
            Row(
              children: [
                Icon(
                  Icons.speed,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                MySpacing.width(8),
                MyText.bodySmall(
                  "Fuel: full to full",
                  fontWeight: 600,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }


}

class SensorWidget extends StatefulWidget {
  final Device sensor;
  const SensorWidget({Key? key, required this.sensor}) : super(key: key);

  @override
  _SensorWidgetState createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {
  final senValue = "Loading...".obs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => getSensorValue(widget.sensor));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MyContainer.bordered(
              color: AppTheme.rentalServiceTheme.scaffoldBackgroundColor,
              borderRadiusAll: Constant.containerRadius.small,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodySmall(
                    widget.sensor.deviceType.kind,
                    xMuted: true,
                    fontWeight: 600,
                  ),
                  MySpacing.height(8),
                  MyText.bodyMedium(
                    widget.sensor.title,
                    fontWeight: 700,
                  ),
                  Obx(() => MyText.bodyLarge(
                    senValue.value,
                    muted: false,
                    fontWeight: 600,
                  )),
                ],
              ),
            ),
          ),
          MySpacing.width(20),
        ],
      ),
    );
  }

  Future<DeviceStatus?> getSensorValue(Device sensor) async {
    var strsenValue = await sensor.getValueDevice(sensor.id).then((value) => value.value);
    senValue.value = strsenValue!;
    return null;
  }
}

class SwitchWidget extends StatefulWidget {
  final Device device;
  const SwitchWidget({Key? key, required this.device}) : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _isOn = false;
  bool _isAvail = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getDeviceStatus();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _getDeviceStatus());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      child: GestureDetector(
        // Get.to(SwitchLogScreen());
        onLongPress: () {
          Get.to(
            SwitchLogScreen(),
            arguments: widget.device.id,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MyContainer.bordered(
                color: AppTheme.rentalServiceTheme.scaffoldBackgroundColor,
                borderRadiusAll: Constant.containerRadius.small,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 5,
                        height: 5,
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          color: _isAvail ? Colors.green : Colors.red,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    MyText.bodySmall(
                      widget.device.deviceType.kind,
                      xMuted: true,
                      fontWeight: 600,
                    ),
                    MySpacing.height(8),
                    MyText.bodyMedium(
                      widget.device.title,
                      fontWeight: 700,
                    ),
                    MySpacing.height(8),
                    Switch(
                      value: _isOn,
                      onChanged: (value) {
                        setState(() {
                          _isOn = value;
                          _setDeviceStatus(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            MySpacing.width(20),
          ],
        ),
      ),
    );
  }

  Future<void> _getDeviceStatus() async {
    final status = await widget.device.getValueDevice(widget.device.id);
    setState(() {
      // print(status)
      _isOn = status.value == 'on';
      if(status.device.status == 1) {
        _isAvail = true;
      } else {
        _isAvail = false;
      }
    });
  }

  Future<void> _setDeviceStatus(bool value) async {
    final status = value ? 'ON' : 'OFF';
    int newValue;

    if (status == 'ON') {
      newValue = 1;
    } else {
      newValue = 0;
    }

    await Device.updateSwitchStatus(widget.device.id, newValue);
  }
}