import 'package:lendo/core/models/restaurant_model.dart';
import 'package:lendo/views/home/details.dart';
import 'package:lendo/views/widgets/rev_text.dart';

import '../apis/resturants_api.dart';
import '../models/error_util.dart';
import 'base_vm.dart';

class RestaurantsViewModel extends BaseModel {
  final RestaurantsApi _api = locator<RestaurantsApi>();
  String? error;

  List<RestaurantModel>? res;
  bool reveal = false;
  Future<void> getAll({bool first = false}) async {
    res = vmContext.read<RestaurantsViewModel>().res;
    setBusy(true);
    try {
      List<RestaurantModel>? data = await _api.getAll();
      if (first) {
        reveal = true;
        setBusy(false);
        await Future.delayed(const Duration(seconds: 5));
      }
      res = data;
      if (first) push(vmContext, DetailsScreen(res: res!.first));
      vmContext.read<RestaurantsViewModel>().res = res;
      setBusy(false);
    } on LendoException catch (e) {
      error = e.message;
      setBusy(false);
    }
  }

  Future<void> getThemed(Map<String, dynamic> data) async {
    res = null;
    setBusy(true);
    try {
      List<RestaurantModel>? themedRes = await _api.getThemed(data);
      reveal = true;
      setBusy(false);
      await Future.delayed(const Duration(seconds: 5));
      res = themedRes;
      vmContext.read<RestaurantsViewModel>().res = res;
      setBusy(true);
      push(vmContext, DetailsScreen(res: res!.first));
    } on LendoException catch (e) {
      error = e.message;
      setBusy(false);
    }
  }

  RestaurantModel? restaurant;
  Future<void> getDetails(id) async {
    setBusy(true);
    try {
      restaurant = await _api.getDetails(id);
      setBusy(false);
    } on LendoException catch (e) {
      error = e.message;
      setBusy(false);
    }
  }

  List<ReviewModel>? reviews;
  Future<void> getReviews(id) async {
    setBusy(true);
    try {
      reviews = await _api.getReviews(id);
      setBusy(false);
    } on LendoException catch (e) {
      error = e.message;
      setBusy(false);
    }
  }

  List<Categories>? categories;
  Future<void> getCategories() async {
    categories = vmContext.read<RestaurantsViewModel>().categories;
    setBusy(true);
    try {
      categories = await _api.getCategories();
      vmContext.read<RestaurantsViewModel>().categories = categories;
      setBusy(false);
    } on LendoException catch (e) {
      error = e.message;
      setBusy(false);
    }
  }
}
