import 'package:consume_rest_api/services/items_Service.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static void setupServiceLocator() {
    GetIt.I.registerLazySingleton(() => ItemsService());
  }

  static T getService<T>() {
    return GetIt.I<T>();
  }
}
