import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/apis/resturants_api.dart';
import 'core/vms/restaurants_vm.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => RestaurantsApi());
  locator.registerFactory(() => RestaurantsViewModel());
}

final List<SingleChildWidget> allProviders = <SingleChildWidget>[
  ChangeNotifierProvider<RestaurantsViewModel>(
      create: (_) => RestaurantsViewModel()),
];
