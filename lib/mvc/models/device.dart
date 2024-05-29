import 'package:sdock_fe/mvc/models/devicestatus.dart';
import 'package:sdock_fe/mvc/models/room.dart';
import 'package:sdock_fe/mvc/services/api_service.dart';

import 'devicetype.dart';
import 'user.dart';


class Device {
  final int id;
  final String title;
  final String description;
  final int status;
  final int ownerId;
  final String secretId;
  final int roomId;
  final int deviceTypeId;
  final User owner;
  final Room room;
  final DeviceType deviceType;

  Device({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.ownerId,
    required this.secretId,
    required this.roomId,
    required this.deviceTypeId,
    required this.owner,
    required this.room,
    required this.deviceType,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json['ID'],
    title: json['title'],
    description: json['description'],
    status: json['status'],
    ownerId: json['owner_id'],
    secretId: json['secret_id'],
    roomId: json['room_id'],
    deviceTypeId: json['device_type_id'],
    owner: User.fromJson(json['owner']),
    room: Room.fromJson(json['room']),
    deviceType: DeviceType.fromJson(json['device_type']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status,
    'owner_id': ownerId,
    'secret_id': secretId,
    'room_id': roomId,
    'device_type_id': deviceTypeId,
    'owner': owner.toJson(),
    'room': room.toJson(),
    'device_type': deviceType.toJson(),
  };

  static Future<List<Device>?> getRoomDevice(int roomID, {String? kind}) async {
    ApiService apiService = ApiService();
    return await apiService.getRoomDevice(roomID, kind: kind!);
  }

  Future<DeviceStatus> getValueDevice(int deviceID) async {
    ApiService apiService = ApiService();
    return await apiService.getValueDevice(deviceID);
  }

  static Future<bool> updateSwitchStatus(int id, int status) async {
    ApiService apiService = ApiService();
    return await apiService.updateSwitchStatus(id, status);
  }
}

class ScanDevice {
  final String ip;
  final String deviceId;

  ScanDevice({
    required this.ip,
    required this.deviceId,
  });

  factory ScanDevice.fromJson(Map<String, dynamic> json) {
    return ScanDevice(
      ip: json['ip'],
      deviceId: json['device_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'device_id': deviceId,
    };
  }

  static Future<List<ScanDevice>?> getParingDevice() async {
    ApiService apiService = ApiService();
    return await apiService.getAllParingDevice();
  }
}