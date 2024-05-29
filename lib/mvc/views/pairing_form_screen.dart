import 'package:get/get.dart';
import 'package:sdock_fe/apps/handyman/worker_information_screen.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/utils/generator.dart';
import 'package:sdock_fe/helpers/widgets/my_card.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sdock_fe/mvc/models/device.dart';

import '../controllers/paring_form_controller.dart';
import '../models/devicetype.dart';
import '../models/room.dart';

class PairingFormScreen extends StatefulWidget {
  const PairingFormScreen({super.key});

  @override
  _PairingFormScreenState createState() => _PairingFormScreenState();
}

class _PairingFormScreenState extends State<PairingFormScreen> {
  final _controller = Get.put(PairingFormController());

  @override
  void initState() {
    super.initState();
    _controller.getDeviceTypes();
    _controller.initializeTheme();
    _controller.room = Get.arguments[0];
    _controller.scan = Get.arguments[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: _controller.customTheme.card,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            LucideIcons.chevronLeft,
            color: _controller.theme.colorScheme.onBackground,
          ),
        ),
        title: MyText.titleLarge("Add to Room: ${_controller.room.title}",
            color: _controller.theme.colorScheme.onBackground,
            fontWeight: 600),
      ),
      body: Container(
        color: _controller.customTheme.card,
        child: ListView(
          padding: MySpacing.fromLTRB(24, 16, 24, 0),
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WorkerInformationScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: _controller.customTheme.border, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                padding: MySpacing.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: MySpacing.left(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: MySpacing.top(4),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        LucideIcons.check,
                                        color: Generator.starColor,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      MyText.bodyMedium("SDOCK Compatible",
                                          color:
                                          theme.colorScheme.onBackground,
                                          fontWeight: 600)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            MyText.bodyMedium(
                              "IP: ${_controller.scan.ip}",
                              color: theme.colorScheme.onBackground,
                              fontWeight: 600,
                            ),
                            MyText.bodySmall(
                                "Device ID: ${_controller.scan.deviceId}",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 600,
                                xMuted: true
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: MySpacing.top(24),
              child: MyText.bodySmall("Device Info",
                  color: theme.colorScheme.onBackground,
                  muted: true,
                  fontWeight: 700),
            ),
            MyCard(
              margin: MySpacing.top(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    style: MyTextStyle.titleSmall(
                        fontWeight: 500, letterSpacing: 0.2),
                    decoration: InputDecoration(
                      hintStyle: MyTextStyle.titleSmall(
                          fontWeight: 500,
                          letterSpacing: 0,
                          color:
                          theme.colorScheme.onBackground.withAlpha(180)),
                      hintText: "Name",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      prefixIcon: const Icon(LucideIcons.mapPin, size: 24),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  TextFormField(
                    style: MyTextStyle.titleSmall(
                        fontWeight: 500, letterSpacing: 0.2),
                    decoration: InputDecoration(
                      hintStyle: MyTextStyle.titleSmall(
                          fontWeight: 500,
                          letterSpacing: 0,
                          color:
                          theme.colorScheme.onBackground.withAlpha(180)),
                      hintText: "Description",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      prefixIcon: const Icon(LucideIcons.mapPin, size: 24),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          readOnly: true,
                          initialValue: _controller.room.title,
                          style: MyTextStyle.titleSmall(
                              fontWeight: 500, letterSpacing: 0.2),
                          decoration: InputDecoration(
                            hintStyle: MyTextStyle.titleSmall(
                                fontWeight: 500,
                                letterSpacing: 0,
                                color: theme.colorScheme.onBackground
                                    .withAlpha(180)),
                            hintText: "City",
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide.none),
                            prefixIcon: const Icon(
                              LucideIcons.building,
                              size: 24,
                            ),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            readOnly: true,
                            initialValue: _controller.room.id.toString(),
                            style: MyTextStyle.titleSmall(
                                fontWeight: 500, letterSpacing: 0.2),
                            decoration: InputDecoration(
                              hintStyle: MyTextStyle.titleSmall(
                                  fontWeight: 500,
                                  letterSpacing: 0,
                                  color: theme.colorScheme.onBackground
                                      .withAlpha(180)),
                              hintText: "Room ID",
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide.none),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide.none),
                              prefixIcon: const Icon(
                                MdiIcons.numeric,
                                size: 24,
                              ),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 0,
                  ),
                  TextFormField(
                    readOnly: true,
                    style: MyTextStyle.titleSmall(
                        fontWeight: 500, letterSpacing: 0.2),
                    decoration: InputDecoration(
                      hintStyle: MyTextStyle.titleSmall(
                          fontWeight: 500,
                          letterSpacing: 0,
                          color:
                          theme.colorScheme.onBackground.withAlpha(180)),
                      hintText: "Name",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      prefixIcon: const Icon(LucideIcons.mapPin, size: 24),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  Obx(() => DropdownButtonFormField<String>(
                    value: _controller.selectedValue.value,
                    onChanged: (newValue) {
                      _controller.selectedValue.value = newValue!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Select a device type',
                      labelStyle: MyTextStyle.titleSmall(
                        fontWeight: 500,
                        letterSpacing: 0.2,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(LucideIcons.mapPin, size: 24),
                    ),
                    items: _controller.deviceTypeNames.map((deviceTypeName) {
                      return DropdownMenuItem(
                        value: deviceTypeName,
                        child: Text(deviceTypeName),
                      );
                    }).toList(),
                  )),
                ],
              ),
            ),
            Container(
              margin: MySpacing.top(32),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withAlpha(28),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding:
                          MaterialStateProperty.all(MySpacing.xy(16, 0))),
                      onPressed: () {},
                      child: MyText.bodyMedium("ADD DEVICE",
                          fontWeight: 600,
                          color: theme.colorScheme.onPrimary,
                          letterSpacing: 0.5)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}