import 'package:flutter_set_test/data/datasource/remote/request/each_coin_history_request.dart';

import '../../util/either.dart';
import '../../util/service_exception.dart';
import '../entities/coin/each_coin_history/each_coin_history_data.dart';
import '../repository/coin_repository.dart';

class GetEachCoinHistoryUseCase {
  late CoinRepository _coinRepository;

  GetEachCoinHistoryUseCase({required CoinRepository coinRepository}) {
    _coinRepository = coinRepository;
  }

  Future<Either<ServiceException, EachCoinHistoryData>> call(EachCoinRequest request) async {
    return await _coinRepository.getEachCoinHistory(request);
  }
}
