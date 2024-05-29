import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:sdock_fe/mvc/controllers/home_controller.dart';
import 'package:sdock_fe/mvc/controllers/single_room_controller.dart';
import 'package:sdock_fe/mvc/models/car.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/theme/constant.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sdock_fe/homes/homes_screen.dart';

import '../models/room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData theme;
  late HomeController controller;
  late OutlineInputBorder outlineInputBorder;


  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = HomeController();
    outlineInputBorder = OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(Constant.containerRadius.medium)),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );
    controller.loadCategoriesAndCars();
    controller.initFormControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Padding(
          padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                title(),
                MySpacing.height(20),
                select(),
                MySpacing.height(20),
                brand(),
                MySpacing.height(20),
                categories(),
                MySpacing.height(20),
                bestCars(),
                MySpacing.height(20),
                cars(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget title() {
    return Padding(
      padding: MySpacing.x(20),
      child: Row(
        children: [
          MyContainer(
            paddingAll: 8,
            borderRadiusAll: Constant.containerRadius.medium,
            child: GestureDetector(
              onTap: () {
                Get.to(() => HomesScreen());
              },
              child: const Icon(
                LucideIcons.mapPin,
                size: 20,
              ),
            ),
          ),
          MySpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodySmall(
                  "Hanoi",
                  xMuted: true,
                ),
                MyText.bodyMedium(
                  "24",
                  fontWeight: 700,
                ),
              ],
            ),
          ),
          const MyContainer.rounded(
            paddingAll: 0,
            height: 40,
            width: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/images/full_apps/rental_service/images/profile.jpg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget select() {
    return MyContainer(
      margin: MySpacing.x(20),
      child: Column(
        children: [
          MyText.titleLarge(
            "Select or search your \nfavourite vehicle",
            fontWeight: 700,
            textAlign: TextAlign.center,
          ),
          MySpacing.height(20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: MyTextStyle.bodyMedium(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      isDense: true,
                      filled: true,
                      prefixIcon: const Icon(LucideIcons.search),
                      hintText: "Search Here",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      hintStyle: MyTextStyle.bodyMedium(xMuted: true),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.searchController.value,
                  cursorColor: theme.colorScheme.onBackground,
                ),
              ),
              MySpacing.width(12),
              MyContainer(
                paddingAll: 13,
                borderRadiusAll: Constant.containerRadius.medium,
                color: theme.colorScheme.primary,
                child: Icon(
                  LucideIcons.list,
                  size: 20,
                  color: theme.colorScheme.onPrimary,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget brand() {
    return Padding(
      padding: MySpacing.x(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.bodyMedium(
            "Rooms",
            fontWeight: 700,
          ),
          GestureDetector(
            onTap: () {
              _showDialog();
            },
            child: MyText.bodySmall(
              "Add a room",
              xMuted: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget categories() {
    List<Widget> list = [];

    list.add(
      MySpacing.width(20),
    );
    for (int i = 0; i < controller.rooms.length; i++) {
      list.add(category(controller.rooms[i]));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget category(Room room) {
    return Container(
      margin: MySpacing.right(20),
      child: InkWell(
        onTap: () {
          // _showDialog();
          controller.goToSingleRoomScreen(room);
        },
        child: ClipRRect(

          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Stack(
            children: [
              Image(
                image: NetworkImage(room.image),
                width: 240,
                height: 240,
                fit: BoxFit.cover,
              ),
              Positioned(
                  left: 16,
                  top: 16,
                  child: MyContainer(
                    paddingAll: 8,
                    color: Colors.black.withAlpha(200),
                    child: MyText.bodySmall(room.title,
                        color: Colors.white, fontWeight: 600),
                  )),
              Positioned(
                  bottom: 16,
                  left: 12,
                  right: 12,
                  child: MyContainer(
                    padding: MySpacing.xy(12, 16),
                    color:
                    Color.lerp(Colors.black, Colors.black, 0.9)!
                        .withAlpha(160),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MyText.titleMedium(room.title,
                                  color: Colors.white, fontWeight: 800),
                            ),
                            const Icon(
                              Icons.bookmark,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                        MySpacing.height(16),
                        MyText.bodySmall(
                            "Hello",
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: 600),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      )
    );
  }

  Widget bestCars({String statusName = "Home"}) {
    return Padding(
      padding: MySpacing.x(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.bodyMedium(
            statusName,
            fontWeight: 700,
          ),
          MyText.bodySmall(
            "See All",
            xMuted: true,
          ),
        ],
      ),
    );
  }

  Widget cars() {
    List<Widget> list = [];

    list.add(MySpacing.width(20));

    for (int i = 0; i < controller.cars.length; i++) {
      // list.add(car(controller.cars[i]));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  // Widget car(Car car) {
  //   return MyContainer(
  //     onTap: () {
  //       controller.goToSingleRoomScreen(car);
  //     },
  //     paddingAll: 4,
  //     borderRadiusAll: Constant.containerRadius.xs,
  //     margin: MySpacing.right(20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         MyContainer(
  //           borderRadiusAll: Constant.containerRadius.xs,
  //           clipBehavior: Clip.antiAliasWithSaveLayer,
  //           paddingAll: 0,
  //           child: Image(
  //             width: 150,
  //             fit: BoxFit.cover,
  //             image: AssetImage(car.image),
  //           ),
  //         ),
  //         Container(
  //           padding: MySpacing.all(8),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               MyText.bodyMedium(
  //                 car.name,
  //                 fontWeight: 700,
  //               ),
  //               MySpacing.height(4),
  //               MyText.bodyMedium(
  //                 "\$${car.price}/hour",
  //                 color: theme.colorScheme.primary,
  //                 fontWeight: 600,
  //               ),
  //               MySpacing.height(4),
  //               Row(
  //                 children: [
  //                   const Icon(
  //                     LucideIcons.mapPin,
  //                     size: 14,
  //                   ),
  //                   MySpacing.width(4),
  //                   MyText.bodySmall(
  //                     car.location,
  //                     xMuted: true,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 100,
  //           width: 100,
  //           child: InkWell(
  //             splashColor: Colors.transparent,
  //             highlightColor: Colors.transparent,
  //             onTap: () {
  //               controller.onClick(car.name as RxString);
  //             },
  //             child: FlareActor(
  //                 "assets/animations/rive/smiley_switch.flr",
  //                 snapToEnd: false,
  //                 animation: controller.status.value
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _showDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a room'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: controller.formMap.value["roomName"] as TextEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Room name',
                  ),
                ),
                TextField(
                  controller: controller.formMap.value["roomDescription"] as TextEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Room description',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: "Select Home",
                  decoration: const InputDecoration(
                    hintText: 'Select Home',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: controller.homesDropdownMap.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(key),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedHome.value = value!;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                controller.addRoom();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
