import 'package:sdock_fe/mvc/models/home.dart';

class HomeSetting {
  int? id;
  int homeId;
  Home homeInfo;
  String key;
  String value;

  HomeSetting({
    this.id,
    required this.homeId,
    required this.homeInfo,
    required this.key,
    required this.value,
  });

  factory HomeSetting.fromJson(Map<String, dynamic> json) => HomeSetting(
    id: json['ID'],
    homeId: json['home_id'],
    homeInfo: Home.fromJson(json['home_info']),
    key: json['key'],
    value: json['value'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'home_id': homeId,
    'home_info': homeInfo.toJson(),
    'key': key,
    'value': value,
  };
}