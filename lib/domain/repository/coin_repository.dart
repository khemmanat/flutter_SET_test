import '../../data/datasource/remote/request/each_coin_history_request.dart';
import '../../util/either.dart';
import '../../util/service_exception.dart';
import '../entities/coin/cois_list_data.dart';
import '../entities/coin/each_coin_history/each_coin_history_data.dart';

abstract class CoinRepository {
  Future<Either<ServiceException, CoinListData>> getCoinList();
  Future<Either<ServiceException, EachCoinHistoryData>> getEachCoinHistory(EachCoinRequest request);
}
