import 'package:sdock_fe/mvc/models/car.dart';
import 'package:sdock_fe/mvc/rental_service_cache.dart';
import 'package:sdock_fe/mvc/views/single_room_screen.dart';
import 'package:get/get.dart';

class SavedController extends GetxController {
  List<Car> cars = [];

  @override
  void onInit() {
    cars = RentalServiceCache.cars;
    super.onInit();
  }

  double findAspectRatio() {
    double width = Get.width;
    // double width = MediaQuery.of(context).size.width;
    return ((width - 60) / 2) / (90 * 2);
  }

  void goToSingleRoomScreen(Car car) {
    // Get.to(
    //   // SingleRoomScreen(car: car),
    // );
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => SingleRoomScreen(
    //       car: car,
    //     ),
    //   ),
    // );
  }
}
