import 'package:sdock_fe/mvc/services/api_service.dart';

import 'user.dart';
import 'device.dart';

class DeviceLog {
  final int id;
  final int deviceId;
  final int ownerId;
  final String value;
  final User owner;
  final Device device;
  final DateTime createdAt;

  DeviceLog({
    required this.id,
    required this.deviceId,
    required this.ownerId,
    required this.value,
    required this.owner,
    required this.device,
    required this.createdAt,
  });

  factory DeviceLog.fromJson(Map<String, dynamic> json) => DeviceLog(
    id: json['ID'],
    deviceId: json['device_id'],
    ownerId: json['owner_id'],
    value: json['value'],
    owner: User.fromJson(json['owner']),
    device: Device.fromJson(json['device']),
    createdAt: DateTime.parse(json['CreatedAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'device_id': deviceId,
    'owner_id': ownerId,
    'value': value,
    'owner': owner.toJson(),
    'device': device.toJson(),
    'CreatedAt': createdAt.toIso8601String(),
  };

  static Future<List<DeviceLog>?> getAllLogDevice(int deviceID) async {
    ApiService apiService = ApiService();
    return await apiService.getAllLogDevice(deviceID);
  }
}