import 'package:sdock_fe/full_apps/m3/learning/models/lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/devicelog.dart';

class SwitchLogController extends GetxController {
  bool uiLoading = true;
  final int deviceID;
  SwitchLogController(this.deviceID);

  List<DeviceLog>? logs;
  late MeetingDataSource events;
  final CalendarController calendarController = CalendarController();

  late DateTime minDate, maxDate;



  @override
  void onInit() {
    super.onInit();
    calendarController.selectedDate = DateTime.now();
    fetchData();
  }

  void goBack() {
    Get.back();
    // Navigator.pop(context);
  }

  fetchData() async {
    print("DeviceID: $deviceID");
    logs = await DeviceLog.getAllLogDevice(deviceID);
    print("DeviceID: $deviceID");
    minDate = logs![0].createdAt;
    maxDate = logs![logs!.length - 1].createdAt;
    events = MeetingDataSource(logs!);
    await Future.delayed(Duration(seconds: 1));
    uiLoading = false;
    update();
  }

  void onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final DateTime currentViewDate = visibleDatesChangedDetails
          .visibleDates[visibleDatesChangedDetails.visibleDates.length ~/ 2];

      if (currentViewDate.month == DateTime.now().month &&
          currentViewDate.year == DateTime.now().year) {
        calendarController.selectedDate = DateTime.now();
      } else {
        calendarController.selectedDate =
            DateTime(currentViewDate.year, currentViewDate.month, 01);
      }
    });
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<DeviceLog> source;

  @override
  List<DeviceLog> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].createdAt;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].createdAt;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  String getSubject(int index) {
    return source[index].owner.username;
  }

  @override
  String? getStartTimeZone(int index) {
    return '';
  }

  @override
  String? getEndTimeZone(int index) {
    return '';
  }

  @override
  Color getColor(int index) {
    if (source[index].value == 'on') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  String? getRecurrenceRule(int index) {
    return '';
  }
}

class Meeting {
  Meeting(
      this.eventName,
      this.organizer,
      this.contactID,
      this.capacity,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.startTimeZone,
      this.endTimeZone,
      this.recurrenceRule);

  String eventName;
  String? organizer;
  String? contactID;
  int? capacity;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? startTimeZone;
  String? endTimeZone;
  String? recurrenceRule;
}
