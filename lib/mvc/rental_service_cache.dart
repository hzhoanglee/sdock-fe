import 'package:sdock_fe/mvc/models/car.dart';
import 'package:sdock_fe/mvc/models/home.dart';

class RentalServiceCache {
  static List<Car> cars = [];
  static List<Home> homes = [];

  static Future<void> initDummy() async {
    // RentalServiceCache.cars = await Car.getDummyList();
    // RentalServiceCache.homes = (await Home.getHomeList())!;
  }
}
