import 'package:flutter_set_test/data/repository/coin_repository_impl.dart';
import 'package:flutter_set_test/domain/use_case/get_each_coin_history_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../domain/use_case/coin_list_use_case.dart';
import 'app_dependency_injection.dart';

class DomainInjection {
  static void inject() {
    injector.pushNewScope(
        scopeName: 'Coin Domain',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<CoinListUseCase>(
              () => CoinListUseCase(coinRepository: getIt.get<CoinRepositoryImpl>()));

          getIt.registerLazySingleton<GetEachCoinHistoryUseCase>(
            () => GetEachCoinHistoryUseCase(
              coinRepository: getIt.get<CoinRepositoryImpl>(),
            ),
          );
        });
  }
}
