import 'package:flutter_set_test/domain/use_case/coin_list_use_case.dart';
import 'package:flutter_set_test/domain/use_case/get_each_coin_history_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../presentation/features/home/bloc/coin_bloc.dart';
import 'app_dependency_injection.dart';

class PresenterInjection {
  static void inject() {
    injector.pushNewScope(
      scopeName: 'Coin',
      init: (GetIt getIt) {
        getIt.registerFactory<CoinBloc>(
          () => CoinBloc(
            coinListUseCase: getIt.get<CoinListUseCase>(),
            getEachCoinHistoryUseCase: getIt.get<GetEachCoinHistoryUseCase>(),
          ),
        );
      },
    );
  }
}
