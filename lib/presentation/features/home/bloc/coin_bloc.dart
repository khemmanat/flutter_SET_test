import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_set_test/domain/entities/coin/each_coin_history/each_coin_history_data.dart';

import '../../../../data/datasource/remote/request/each_coin_history_request.dart';
import '../../../../domain/entities/coin/coin_data.dart';
import '../../../../domain/entities/coin/coin_each_history_result_data.dart';
import '../../../../domain/entities/coin/cois_list_data.dart';
import '../../../../domain/use_case/coin_list_use_case.dart';
import '../../../../domain/use_case/get_each_coin_history_use_case.dart';
import '../../../../util/either.dart';
import '../../../../util/service_exception.dart';

part 'coin_event.dart';
part 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  late CoinListUseCase _coinListUseCase;
  late GetEachCoinHistoryUseCase _getEachCoinHistoryUseCase;
  CoinBloc({
    required CoinListUseCase coinListUseCase,
    required GetEachCoinHistoryUseCase getEachCoinHistoryUseCase,
  }) : super(CoinInitial()) {
    // use case
    _coinListUseCase = coinListUseCase;
    _getEachCoinHistoryUseCase = getEachCoinHistoryUseCase;

    // event
    on<FetchCoinListEvent>(_onFetchCoinListEvent);
    on<FetchEachCoinHistoryEvent>(_onFetchEachCoinHistoryEvent);
  }

  void _onFetchCoinListEvent(FetchCoinListEvent event, Emitter<CoinState> emit) async {
    try {
      emit(CoinLoadingState());
      Either<ServiceException, CoinListData> result = await _coinListUseCase.call();
      result.either((error) {
        emit(CoinListErrorState(message: error.toString()));
      }, (value) {
        emit(CoinListLoadedState(coinList: value.coinList));
      });
    } catch (e) {
      emit(CoinListErrorState(message: e.toString()));
    }
  }

  void _onFetchEachCoinHistoryEvent(FetchEachCoinHistoryEvent event, Emitter<CoinState> emit) async {
    try {
      emit(CoinLoadingState());
      final yesterdayDate = DateTime.now().subtract(Duration(days: 1));
      final todayDate = DateTime.now();
      final yesterday = "${yesterdayDate.day}-${yesterdayDate.month}-${yesterdayDate.year}";
      final today = "${todayDate.day}-${todayDate.month}-${todayDate.year}";
      final EachCoinRequest yesterdayRequest = EachCoinRequest(id: event.id, date: yesterday);
      Either<ServiceException, EachCoinHistoryData> yesterdayResult =
          await _getEachCoinHistoryUseCase.call(yesterdayRequest);

      late EachCoinHistoryData yesterdayHistory;
      late EachCoinHistoryData todayHistory;

      yesterdayResult.either((error) {
        emit(CoinListErrorState(message: error.toString()));
      }, (value) {
        yesterdayHistory = value;
      });

      final EachCoinRequest todayRequest = EachCoinRequest(id: event.id, date: today);
      Either<ServiceException, EachCoinHistoryData> todayResult = await _getEachCoinHistoryUseCase.call(todayRequest);

      todayResult.either((error) {
        emit(CoinListErrorState(message: error.toString()));
      }, (value) {
        todayHistory = value;
      });

      final String symbol = todayHistory.symbol ?? '';

      final prevPrice = double.parse((yesterdayHistory.marketData?.currentPrice.usd ?? 0).toStringAsFixed(2));
      log('prevPrice : $prevPrice');
      final currentPrice = double.parse((todayHistory.marketData?.currentPrice.usd ?? 0).toStringAsFixed(2));
      log('currentPrice : $currentPrice');
      final priceChange = double.parse((((currentPrice - prevPrice) / prevPrice) * 100).toStringAsFixed(2));
      log('priceChange : $priceChange');

      final prevMarketCap = double.parse((yesterdayHistory.marketData?.marketCap.usd ?? 0).toStringAsFixed(2));
      log('prevMarketCap : $prevMarketCap');
      final currentMarketCap = double.parse((todayHistory.marketData?.marketCap.usd ?? 0).toStringAsFixed(2));
      log('currentMarketCap : $currentMarketCap');
      final double marketCapChange =
          double.parse((((currentMarketCap - prevMarketCap) / prevMarketCap) * 100).toStringAsFixed(2));

      log('marketCapChange : $marketCapChange');

      final prevTotalVolume = double.parse((yesterdayHistory.marketData?.totalVolume.usd ?? 0).toStringAsFixed(2));
      log('prevTotalVolume : $prevTotalVolume');
      final currentTotalVolume = double.parse((todayHistory.marketData?.totalVolume.usd ?? 0).toStringAsFixed(2));
      log('currentTotalVolume : $currentTotalVolume');
      final double totalVolumeChange =
          double.parse((((currentTotalVolume - prevTotalVolume) / prevTotalVolume) * 100).toStringAsFixed(2));

      log('totalVolumeChange : $totalVolumeChange');
      final coinEachHistoryResultData = CoinEachHistoryResultData(
        id: event.id,
        symbol: symbol,
        prevPrice: prevPrice,
        currentPrice: currentPrice,
        priceChange: priceChange,
        prevMarketCap: prevMarketCap,
        currentMarketCap: currentMarketCap,
        marketCapChange: marketCapChange,
        prevTotalVolume: prevTotalVolume,
        currentTotalVolume: currentTotalVolume,
        totalVolumeChange: totalVolumeChange,
      );
      emit(CoinEachLoadedState(coinData: coinEachHistoryResultData));
    } catch (e) {
      emit(CoinListErrorState(message: e.toString()));
    }
  }
}
