import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../util/either.dart';
import '../../../util/service_exception.dart';
import 'request/each_coin_history_request.dart';
import 'response/coin/coin_list_response.dart';
import 'response/coin/each_coin_history_response.dart';

/// Coin Remote
/// The remote data source for the Coin feature.
/// It is responsible for handling all the network calls.
class CoinRemote {
  final Dio _dio;

  CoinRemote({required Dio dio}) : _dio = dio;

  Future<Either<DataParsingException, CoinListResponse>> coinList() async {
    log('CoinRemote');
    Response response = await _dio.get('https://api.coingecko.com/api/v3/coins/list');

    log(response.data.runtimeType.toString());
    try {
      List<dynamic> list = response.data;

      log('CoinRemote try');
      return Right(CoinListResponse.fromJson({'coinList': list}));
    } catch (e) {
      return Left(DataParsingException());
    }
  }

  Future<Either<DataParsingException, EachCoinHistoryResponse>> eachCoinHistory(EachCoinRequest request) async {
    Response response =
        await _dio.get('https://api.coingecko.com/api/v3/coins/${request.id}/history?date=${request.date}');

    try {
      return Right(EachCoinHistoryResponse.fromJson(response.data));
    } catch (e) {
      return Left(DataParsingException());
    }
  }
}
