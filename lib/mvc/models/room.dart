import 'package:sdock_fe/mvc/models/user.dart';
import 'package:sdock_fe/mvc/services/api_service.dart';

class Room {
  int? id;
  String title;
  String description;
  int status;
  int homeId;
  int ownerId;
  User owner;
  String image;

  Room({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.homeId,
    required this.ownerId,
    required this.owner,
    required this.image,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json['ID'],
    title: json['title'],
    description: json['description'],
    status: json['status'],
    homeId: json['home_id'],
    ownerId: json['owner_id'],
    owner: User.fromJson(json['owner']),
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'title': title,
    'description': description,
    'status': status,
    'home_id': homeId,
    'owner_id': ownerId,
    'owner': owner.toJson(),
    'image': image,
  };

  static Future<List<Room>?> getRoomList(int homeID) async {
    ApiService apiService = ApiService();
    return await apiService.getRoomList(homeID);
  }

  static Future<bool> addRoom(Map<String, dynamic> map) async {
    ApiService apiService = ApiService();
    return await apiService.createRoom(map);
  }

}