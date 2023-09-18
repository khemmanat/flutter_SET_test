import 'dart:developer';

import 'package:flutter_set_test/data/datasource/remote/coin_remote.dart';
import 'package:flutter_set_test/data/datasource/remote/request/each_coin_history_request.dart';
import 'package:flutter_set_test/domain/entities/coin/cois_list_data.dart';
import 'package:flutter_set_test/domain/entities/coin/each_coin_history/coin_image_data.dart';
import 'package:flutter_set_test/domain/entities/coin/each_coin_history/coin_localization_data.dart';
import 'package:flutter_set_test/domain/entities/coin/each_coin_history/coin_market_cap_data.dart';
import 'package:flutter_set_test/util/service_exception.dart';

import '../../domain/entities/coin/coin_data.dart';
import '../../domain/entities/coin/each_coin_history/coin_current_price_data.dart';
import '../../domain/entities/coin/each_coin_history/coin_market_data_data.dart';
import '../../domain/entities/coin/each_coin_history/coin_total_volume_data.dart';
import '../../domain/entities/coin/each_coin_history/each_coin_history_data.dart';
import '../../domain/repository/coin_repository.dart';
import '../../util/either.dart';

class CoinRepositoryImpl extends CoinRepository {
  late final CoinRemote _remote;
  CoinRepositoryImpl({required CoinRemote remote}) : _remote = remote;

  @override
  Future<Either<ServiceException, CoinListData>> getCoinList() async {
    log('CoinRepositoryImpl');
    final result = await _remote.coinList();
    if (result.isLeft) {
      log('list left');
      return Left(result.left);
    } else {
      try {
        if (result.right.coinList.isNotEmpty) {
          log('list right');
          return Right(CoinListData(
            coinList: result.right.coinList
                .map((e) => CoinData(
                      id: e.id,
                      symbol: e.symbol,
                      name: e.name,
                    ))
                .toList(),
          ));
        } else {
          return Left(ServiceException(message: 'error'));
        }
      } catch (e) {
        log('list right error');
        return Left(DataParsingException());
      }
    }
  }

  @override
  Future<Either<ServiceException, EachCoinHistoryData>> getEachCoinHistory(EachCoinRequest request) async {
    final result = await _remote.eachCoinHistory(request);

    if (result.isLeft) {
      return Left(result.left);
    } else {
      try {
        if (result.right.id != null) {
          return Right(EachCoinHistoryData(
            id: result.right.id,
            symbol: result.right.symbol,
            name: result.right.name,
            localization: CoinLocalizationData(
              en: result.right.localization?.en ?? '',
            ),
            image: CoinImageData(
              thumb: result.right.image?.thumb ?? '',
              small: result.right.image?.small ?? '',
            ),
            marketData: CoinMarketDataData(
              currentPrice: CoinCurrentPriceData(usd: result.right.marketData?.currentPrice.usd ?? 0),
              marketCap: CoinMarketCapData(usd: result.right.marketData?.marketCap.usd ?? 0),
              totalVolume: CoinTotalVolumeData(usd: result.right.marketData?.totalVolume.usd ?? 0),
            ),
          ));
        } else {
          return Left(ServiceException(message: 'error'));
        }
      } catch (e) {
        return Left(DataParsingException());
      }
    }
  }
}
