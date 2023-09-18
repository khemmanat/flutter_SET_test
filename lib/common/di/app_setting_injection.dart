import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'app_dependency_injection.dart';

class AppSettingInjection {
  static void inject() {
    // BaseOptions options = BaseOptions(baseUrl: AppEnvironment.instance.baseURL);
    injector.pushNewScope(
        scopeName: 'App Setting',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<Dio>(() => Dio());
        });
  }
}
