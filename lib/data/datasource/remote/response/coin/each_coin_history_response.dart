import 'package:flutter_set_test/data/datasource/remote/response/coin/coin_market_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'coin_image_response.dart';
import 'coin_localization_response.dart';

part 'each_coin_history_response.g.dart';

@JsonSerializable()
class EachCoinHistoryResponse {
  final String? error;
  final String? id;
  final String? symbol;
  final String? name;
  final CoinLocalizationResponse? localization;
  final CoinImageResponse? image;
  @JsonKey(name: 'market_data')
  final CoinMarketDataResponse? marketData;

  EachCoinHistoryResponse({
    this.error,
    this.id,
    this.symbol,
    this.name,
    this.localization,
    this.image,
    this.marketData,
  });

  factory EachCoinHistoryResponse.fromJson(Map<String, dynamic> json) => _$EachCoinHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EachCoinHistoryResponseToJson(this);
}
