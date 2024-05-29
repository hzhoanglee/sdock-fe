import 'package:sdock_fe/mvc/models/homesetting.dart';
import 'package:sdock_fe/mvc/models/room.dart';
import 'package:sdock_fe/mvc/models/user.dart';
import 'package:sdock_fe/mvc/services/api_service.dart';

class Home {
  int? id;
  String title;
  String? description;
  int status;
  int ownerId;
  String long;
  String lat;
  User owner;
  List<Room> rooms;
  List<HomeSetting> homeSettings;

  Home({
    this.id,
    required this.title,
    this.description,
    required this.status,
    required this.ownerId,
    required this.long,
    required this.lat,
    required this.owner,
    required this.rooms,
    required this.homeSettings,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
    id: json['ID'],
    title: json['title'],
    description: json['description'],
    status: json['status'],
    ownerId: json['owner_id'],
    long: json['long'],
    lat: json['lat'],
    owner: User.fromJson(json['owner']),
    rooms: List<Room>.from(json['rooms'].map((x) => Room.fromJson(x))),
    homeSettings:
    List<HomeSetting>.from(json['home_setting'].map((x) => HomeSetting.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'title': title,
    'description': description,
    'status': status,
    'owner_id': ownerId,
    'long': long,
    'lat': lat,
    'owner': owner.toJson(),
    'rooms': rooms.map((x) => x.toJson()).toList(),
    'home_setting': homeSettings.map((x) => x.toJson()).toList(),
  };

  static Future<List<Home>?> getHomeList() async {
    ApiService apiService = ApiService();
    return await apiService.getHomeList();
  }

}