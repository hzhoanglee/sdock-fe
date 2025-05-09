import 'dart:convert';

import 'package:sdock_fe/helpers/extensions/extensions.dart';
import 'package:flutter/services.dart';

class Recipe {
  final String title, tag, image;
  final int preparationTime, serving;
  final bool favourite;

  Recipe(this.title, this.tag, this.image, this.preparationTime, this.serving,
      this.favourite);

  static Future<List<Recipe>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Recipe> getOne() async {
    return (await getDummyList())[0];
  }

  static Recipe fromJson(Map<String, dynamic> jsonObject) {
    String title = jsonObject['title'].toString();
    String tag = jsonObject['tag'].toString();
    String image = jsonObject['image'].toString();
    int preparationTime = jsonObject['preparation_time'].toString().toInt();
    int serving = jsonObject['serving'].toString().toInt();
    bool favourite = jsonObject['favourite'].toString().toBool();

    return Recipe(title, tag, image, preparationTime, serving, favourite);
  }

  static List<Recipe> getListFromJson(List<dynamic> jsonArray) {
    List<Recipe> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Recipe.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle
        .loadString('assets/full_apps/m3/cookify/data/recipes.json');
  }
}
