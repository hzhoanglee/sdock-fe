import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sdock_fe/mvc/models/device.dart';
import 'package:sdock_fe/mvc/models/devicelog.dart';
import 'package:sdock_fe/mvc/models/devicestatus.dart';
import 'package:sdock_fe/mvc/models/devicetype.dart';
import 'package:sdock_fe/mvc/models/home.dart';
import 'package:sdock_fe/mvc/models/room.dart';
import 'package:sdock_fe/mvc/services/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<List<T>?> getList<T>(String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var url = Uri.parse(ApiConstants.baseUrl + endpoint);
      var authHeader = {'Authorization': 'Bearer $token'};
      var response = await http.get(url, headers: authHeader);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        // print(responseBody['data']);
        if (responseBody['data'] is List) {
          return (responseBody['data'] as List).map((item) => fromJson(item)).toList();
        }
      }
    } catch (e) {
      print('Exception: $e');
      print('Trace: ${StackTrace.current}');
    }
    return null;
  }

  Future<T> getSingleEntity<T>(String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var url = Uri.parse(ApiConstants.baseUrl + endpoint);
      var authHeader = {'Authorization': 'Bearer $token'};
      var response = await http.get(url, headers: authHeader);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['data'] is Map<String, dynamic>) {
          return fromJson(responseBody['data']);
        }
      }
    } catch (e) {
      print('Exception: $e');
      print('Trace: ${StackTrace.current}');
    }
    return fromJson({});
  }

  Future<Map<String, dynamic>> createEntity(String endpoint, Map<String, dynamic> body) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var url = Uri.parse(ApiConstants.baseUrl + endpoint);
      var authHeader = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      var response = await http.post(url, headers: authHeader, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (kDebugMode) {
          print(responseBody);
        }
        return responseBody;
      } else {
        if (kDebugMode) {
          print('Failed to create entity');
        }
        return {};
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
        print('Trace: ${StackTrace.current}');
      }
      return {};
    }
  }


  Future<List<Home>?> getHomeList() async {
    var list = getList(ApiConstants.getHomeList, Home.fromJson);
    return list;
  }

  Future<List<Room>?> getRoomList(int homeId) async {
    return getList(ApiConstants.getRoomList + homeId.toString(), Room.fromJson);
  }

  Future<List<Device>?> getRoomDevice(int roomId, {String kind = ""}) async {
    print("${ApiConstants.getRoomDevice}$roomId?kind=$kind");
    return getList("${ApiConstants.getRoomDevice}$roomId?kind=$kind", Device.fromJson);
  }

  Future<DeviceStatus> getValueDevice(int deviceId) async {
    return await getSingleEntity<DeviceStatus>(
      "${ApiConstants.getValueDevice}$deviceId",
      DeviceStatus.fromJson,
    );
  }

  Future<bool> updateSwitchStatus(int deviceId, int value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.setValueDevice);
      var authHeader = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        'device_id': deviceId,
        'status': value,
      });
      var response = await http.post(url, headers: authHeader, body: body);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (kDebugMode) {
          print(responseBody);
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to update switch status');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
        print('Trace: ${StackTrace.current}');
      }
      return false;
    }
  }

  Future<List<DeviceLog>?> getAllLogDevice(int deviceId) async {
    print("${ApiConstants.getLogDevice}$deviceId");
    return getList("${ApiConstants.getLogDevice}$deviceId", DeviceLog.fromJson);
  }

  Future<List<ScanDevice>?> getAllParingDevice() async {
    return getList(ApiConstants.getParingDevice, ScanDevice.fromJson);
  }

  Future<List<DeviceType>?> getSwitchTypeDevice() async {
    return getList(ApiConstants.getSwitchTypeDevice, DeviceType.fromJson);
  }

  Future<bool> createRoom(Map<String, dynamic> body) async {
    var response = await createEntity(ApiConstants.createRoom, body);
    var status = response['status'];
    if (status == 'success') {
      return true;
    }
    return false;
  }

}