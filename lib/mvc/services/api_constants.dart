class ApiConstants {
  static String rootUrl = 'http://HoangsLe-MacBook-Pro.local:3000';
  static String baseUrl = 'http://HoangsLe-MacBook-Pro.local:3000/api/v1';
  static String getHomeList = '/home/all';

 // Room
  static String getRoomList = '/room/all/'; // home_id
  static String getRoomDevice = '/room/devices/all/' ; // room_id
  static String getValueDevice = '/device/status/get/'; // device_id
  static String createRoom = '/room/create';
  static String setValueDevice = '/device/status/set';
  static String getLogDevice = '/device/log/get/';
  static String getParingDevice = '/device_paring/scan';
  static String getSwitchTypeDevice = '/device_paring/type?kind=SWITCH';
}