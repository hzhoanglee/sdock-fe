import 'package:sdock_fe/mvc/models/car.dart';
import 'package:sdock_fe/mvc/rental_service_cache.dart';
import 'package:sdock_fe/mvc/views/single_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionController extends GetxController {
  List<Car> cars = [];
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    cars = RentalServiceCache.cars;
    super.onInit();
  }

  // void goToSingleRoomScreen(Car car) {
  //   Get.to(
  //     SingleRoomScreen(
  //       car: car,
  //     ),
  //   );
  //   // Navigator.of(context, rootNavigator: true).push(
  //   //   MaterialPageRoute(
  //   //     builder: (context) => SingleRoomScreen(
  //   //       car: car,
  //   //     ),
  //   //   ),
  //   // );
  // }
}
