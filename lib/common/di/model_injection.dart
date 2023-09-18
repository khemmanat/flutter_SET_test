import 'package:dio/dio.dart';
import 'package:flutter_set_test/data/datasource/remote/coin_remote.dart';
import 'package:flutter_set_test/data/repository/coin_repository_impl.dart';
import 'package:get_it/get_it.dart';

import 'app_dependency_injection.dart';

/// Data model injection
class ModelInjection {
  static void inject() {
    injector.pushNewScope(
        scopeName: 'Coin Model',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<CoinRemote>(() => CoinRemote(dio: GetIt.I.get<Dio>()));
          getIt.registerLazySingleton<CoinRepositoryImpl>(() => CoinRepositoryImpl(remote: getIt.get<CoinRemote>()));
        });
  }
}
