import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sdock_fe/animations/switch/switch_controller.dart';
import 'package:sdock_fe/mvc/models/car.dart';
import 'package:sdock_fe/mvc/models/home.dart';
import 'package:sdock_fe/mvc/models/room.dart';
import 'package:sdock_fe/mvc/rental_service_cache.dart';
import 'package:sdock_fe/mvc/services/api_constants.dart';
import 'package:sdock_fe/mvc/views/single_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class HomeController extends GetxController {
  var searchController = TextEditingController().obs;
  var rooms = <Room>[].obs;
  var cars = <Car>[].obs;
  late SwitchController switchController;
  var status = "Off".obs;
  var toggleValue = false.obs;
  var formMap = <String, dynamic>{}.obs;
  var homesDropdownMap = <String, int>{
    "Select Home": 0,
  }.obs;
  var selectedHome = "Select Home".obs;


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> loadCategoriesAndCars() async {
    List<Home>? homesList = await Home.getHomeList();

    for (Home home in homesList ?? []) {
      homesDropdownMap[home.title ?? ""] = home.id ?? 0;
    }

    List<Room>? roomsList = await Room.getRoomList(homesList?[0].id ?? 0);

    for (Room room in roomsList ?? []) {
      if(!room.image.contains("http")) {
        room.image = ApiConstants.rootUrl + room.image;
      }
      rooms.add(room);
    }
    rooms = roomsList!.obs;

    cars = RentalServiceCache.cars.obs;
    switchController = SwitchController();
  }

  void goToSingleRoomScreen(Room room) {
    Get.to(
      SingleRoomScreen(room: room),
    );
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => SingleRoomScreen(
    //       car: car,
    //     ),
    //   ),
    // );
  }

  void onClick(RxString name) {
    if (status.compareTo("Off") == 0) {
      status = "On" as RxString;
      update();
    } else {
      status = "Off" as RxString;
      update();
    }
  }

  void goBack() {
    Get.back();
    // Navigator.pop(context);
  }

  void toggleButton() {
    toggleValue.value = !toggleValue.value;
  }

  void initFormControllers() {
    formMap.value = {
      "roomName": TextEditingController(),
      "roomDescription": TextEditingController(),

    };
  }

  void addRoom() async {
    Map<String, dynamic> formData = {
      "title": formMap.value["roomName"]!.text,
      "home_id": homesDropdownMap[selectedHome.value]
    };

    var status = Room.addRoom(formData);

    if (await status) {
      Get.snackbar("Success", "Room added successfully");
      rooms.clear();
      List<Room>? roomsList = await Room.getRoomList(homesDropdownMap[selectedHome.value] ?? 0);
      for (Room room in roomsList ?? []) {
        rooms.add(room);
      }
    } else {
      Get.snackbar("Error", "Failed to add room");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Failed to add room"),
      //   ),
      // );
    }

  }

}
