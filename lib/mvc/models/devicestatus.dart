
import 'device.dart';

class DeviceStatus {
  final int id;
  final int deviceId;
  final int status;
  final String? value;
  final Device device;

  DeviceStatus({
    required this.id,
    required this.deviceId,
    required this.status,
    this.value,
    required this.device,
  });

  factory DeviceStatus.fromJson(Map<String, dynamic> json) => DeviceStatus(
    id: json['ID'],
    deviceId: json['device_id'],
    status: json['status'],
    value: json['value'],
    device: Device.fromJson(json['device']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'device_id': deviceId,
    'status': status,
    'value': value,
    'device': device.toJson(),
  };
}