import 'package:sdock_fe/mvc/models/device.dart';

import '../services/api_service.dart';

class DeviceType {
  final int id;
  final String name;
  final String code;
  final String kind;
  final String? initialValue;
  final String? icon;
  // final List<Device> devices;

  DeviceType({
    required this.id,
    required this.name,
    required this.code,
    required this.kind,
    this.initialValue,
    this.icon,
    // required this.devices,
  });

  factory DeviceType.fromJson(Map<String, dynamic> json) => DeviceType(
    id: json['ID'],
    name: json['name'],
    code: json['code'],
    kind: json['kind'],
    initialValue: json['initial_value'],
    icon: json['icon'],
    // devices: List<Device>.from(
    //     json['devices'].map((x) => Device.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'kind': kind,
    'initial_value': initialValue,
    'icon': icon,
    // 'devices': List<dynamic>.from(devices.map((x) => x.toJson())),
  };

  static Future<List<DeviceType>?> getSwitchTypeDevice() async {
    ApiService apiService = ApiService();
    return await apiService.getSwitchTypeDevice();
  }
}