import 'package:sdock_fe/mvc/models/car.dart';
import 'package:sdock_fe/mvc/models/device.dart';
import 'package:sdock_fe/mvc/models/room.dart';
import 'package:sdock_fe/mvc/views/payment_screen.dart';
import 'package:get/get.dart';

import '../views/switch_log_screen.dart';

class SingleRoomController extends GetxController {
  Room room;
  SingleRoomController(this.room);
  bool fav = false;
  var devices = <Device>[].obs;
  final RxList<Device> _sensors = <Device>[].obs;
  final RxList<Device> _switches = <Device>[].obs;
  List<Device> get sensors => _sensors;
  List<Device> get switches => _switches;

  @override
  Future<void> onInit() async {
    await loadRoomDevices();
    super.onInit();
  }

  Future<void> loadRoomDevices() async {
    _sensors.clear();
    _switches.clear();
    List<Device>? sensorsList = await Device.getRoomDevice(room.id!, kind: "sensor");
    List<Device>? switchesList = await Device.getRoomDevice(room.id!, kind: "switch");
    _sensors.addAll(sensorsList!);
    _switches.addAll(switchesList!);
  }

  Future<bool> setValueSwitch(int deviceID, int status) async {
    return await Device.updateSwitchStatus(deviceID, status);
  }

  void toggleFav() {
    fav = !fav;
    update();
  }

  void goToPaymentScreen() {
    Get.off(PaymentScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => PaymentScreen(),
    //   ),
    // );
  }


  void goBack() {
    Get.back();
    // Navigator.pop(context);
  }
}
