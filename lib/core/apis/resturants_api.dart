import 'dart:convert';

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
      /*  'price': data?['price_max'],
      'attributes': data?['attributes'],*/
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
          String raw =
              "{\n  \"possible_languages\": [\n    \"en\"\n  ],\n  \"reviews\": [\n    {\n      \"id\": \"xAG4O7l-t1ubbwVAlPnDKg\",\n      \"url\": \"https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w\",\n      \"text\": \"Went back again to this place since the last time i visited the bay area 5 months ago, and nothing has changed. Still the sketchy Mission, Still the cashier...\",\n      \"rating\": 5,\n      \"time_created\": \"2016-08-29 00:41:13\",\n      \"user\": {\n        \"id\": \"W8UK02IDdRS2GL_66fuq6w\",\n        \"profile_url\": \"https://www.yelp.com/user_details?userid=W8UK02IDdRS2GL_66fuq6w\",\n        \"image_url\": \"https://s3-media3.fl.yelpcdn.com/photo/iwoAD12zkONZxJ94ChAaMg/o.jpg\",\n        \"name\": \"Ella A.\"\n      }\n    },\n    {\n      \"id\": \"1JNmYjJXr9ZbsfZUAgkeXQ\",\n      \"url\": \"https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=fj87uymFDJbq0Cy5hXTHIA&adjust_creative=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w\",\n      \"text\": \"The restaurant is inside a small deli so there is no sit down area. Just grab and go. Inside, they sell individually packaged ingredients so that you can...\",\n      \"rating\": 4,\n      \"time_created\": \"2016-09-28 08:55:29\",\n      \"user\": {\n        \"id\": \"rk-MwIUejOj6LWFkBwZ98Q\",\n        \"profile_url\": \"https://www.yelp.com/user_details?userid=rk-MwIUejOj6LWFkBwZ98Q\",\n        \"image_url\": \"\",\n        \"name\": \"Yanni L.\"\n      }\n    },\n    {\n      \"id\": \"SIoiwwVRH6R2s2ipFfs4Ww\",\n      \"url\": \"https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=m_tnQox9jqWeIrU87sN-IQ&adjust_creative=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w\",\n      \"text\": \"Dear Mission District, I miss you and your many delicious late night food establishments and vibrant atmosphere.  I miss the way you sound and smell on a...\",\n      \"rating\": 4,\n      \"time_created\": \"2016-08-10 07:56:44\",\n      \"user\": {\n        \"id\": \"rpOyqD_893cqmDAtJLbdog\",\n        \"profile_url\": \"https://www.yelp.com/user_details?userid=rpOyqD_893cqmDAtJLbdog\",\n        \"image_url\": \"\",\n        \"name\": \"Suavecito M.\"\n      }\n    }\n  ],\n  \"total\": 3\n}";
          List<ReviewModel> dirs = [];
          (jsonDecode(raw)['reviews'] ?? []).forEach((a) {
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
