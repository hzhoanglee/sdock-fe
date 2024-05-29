import 'package:get/get.dart';

class SwitchController extends GetxController {
  SwitchController();

  String status = "Off";
  bool toggleValue = false;

  set _homeScreenState(homeScreenState) {}

  void onClick(String elementId) {
    print(elementId);
    if (status.compareTo("Off") == 0) {
      status = "On";
      update();
    } else {
      status = "Off";
      update();
    }
  }

  void goBack() {
    Get.back();
    // Navigator.pop(context);
  }

  toggleButton() {
    toggleValue = !toggleValue;
    update();
  }

  void init(homeScreenState) {
    _homeScreenState = homeScreenState;
  }
}
