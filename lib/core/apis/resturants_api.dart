import 'dart:convert';

import '../../views/widgets/utils.dart';
import '../models/restaurant_model.dart';
import 'base_api.dart';

class RestaurantsApi extends BaseAPI {
  Future<List<RestaurantModel>> getAll() async {
    String url = 'businesses/search';
    dynamic data = AppCache.getFilter();
    String category =
        data?['category'].map((e) => e['alias']).toList().join(',') ?? '';
    Map<String, dynamic> params = {
      'term': 'Dining Spot',
      'limit': 20,
      'open_now': data?['open_now'] ?? true,
      'location': data?['location'],
      if (category.isNotEmpty) 'categories': category,
    };

    log(params);
    try {
      final Response res = await dio().get(url, queryParameters: params);
      // log(res.data);
      switch (res.statusCode) {
        case 200:
          List<RestaurantModel> dirs = [];
          (res.data['businesses'] ?? []).forEach((a) {
            dirs.add(RestaurantModel.fromJson(a));
          });
          return dirs;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw LendoException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<RestaurantModel>> getThemed(Map<String, dynamic> data) async {
    String url = 'businesses/search';
    data['location'] = AppCache.getFilter()?['location'];

    log(data);
    try {
      final Response res = await dio().get(url, queryParameters: data);
      // log(res.data);
      switch (res.statusCode) {
        case 200:
          List<RestaurantModel> dirs = [];
          (res.data['businesses'] ?? []).forEach((a) {
            dirs.add(RestaurantModel.fromJson(a));
          });
          return dirs;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw LendoException(DioErrorUtil.handleError(e));
    }
  }

  Future<RestaurantModel> getDetails(String? id) async {
    String url = '/businesses/$id';
    try {
      final Response res = await dio().get(url);
      //  log(res.data);
      switch (res.statusCode) {
        case 200:
          return RestaurantModel.fromJson(res.data);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw LendoException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<ReviewModel>> getReviews(String? id) async {
    String url = 'businesses/$id/reviews?limit=20&sort_by=newest';

    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          List<ReviewModel> dirs = [];
          (res.data['reviews'] ?? []).forEach((a) {
            dirs.add(ReviewModel.fromJson(a));
          });
          return dirs;
        case 404:
          List<ReviewModel> dirs = [];
          (jsonDecode(Utils.reviewData)['reviews'] ?? []).forEach((a) {
            dirs.add(ReviewModel.fromJson(a));
          });
          return dirs;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw LendoException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<Categories>> getCategories() async {
    String url = 'categories?locale=en_US';

    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          List<Categories> dirs = [];
          (res.data['data'] ?? []).forEach((a) {
            dirs.add(Categories.fromJson(a));
          });
          return dirs;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw LendoException(DioErrorUtil.handleError(e));
    }
  }
}
