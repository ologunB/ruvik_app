import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:lendo/core/models/restaurant_model.dart';

class AppCache {
  static const String kUserBox = 'userBox';
  static const String restaurantFilterKey = 'restaurantFilterKey';
  static const String savedRestaurantKey = 'savedRestaurantKey';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(kUserBox);
    // await clear();
  }

  static Box<dynamic> get _userBox => Hive.box<dynamic>(kUserBox);

  static dynamic getFilter() {
    return _userBox.get(restaurantFilterKey, defaultValue: {});
  }

  static Future<void> setFilter(dynamic data) async {
    await _userBox.put(restaurantFilterKey, data);
  }

  static List<RestaurantModel> getSavedRestaurants() {
    List<RestaurantModel> list = [];
    for (var str in _getRestaurants()) {
      list.add(RestaurantModel.fromJson(jsonDecode(str)));
    }
    return list;
  }

  static List<String> _getRestaurants() {
    return _userBox.get(savedRestaurantKey, defaultValue: <String>[])
        as List<String>;
  }

  static final StreamController<int> _downloadsController =
      StreamController<int>.broadcast();
  static Sink<int> get _inMainDownloads => _downloadsController.sink;
  static Stream<int> get outMainDownloads => _downloadsController.stream;

  static Future<void> setSavedRestaurants(RestaurantModel data) async {
    List<String> saved = _getRestaurants();
    bool present = false;
    for (var str in saved) {
      if (str.contains(data.id!)) {
        present = true;
      }
    }
    if (!present) saved.add(jsonEncode(data.toJson()));
    _inMainDownloads.add(1);

    await _userBox.put(savedRestaurantKey, saved);
  }

  static Future<void> clear([bool all = false]) async {
    await _userBox.clear();
  }
}
