import 'package:json_annotation/json_annotation.dart';

import 'coin_current_price_response.dart';
import 'coin_market_cap_response.dart';
import 'coin_total_volume_response.dart';

part 'coin_market_data_response.g.dart';

@JsonSerializable()
class CoinMarketDataResponse {
  @JsonKey(name: 'current_price')
  final CoinCurrentPriceResponse currentPrice;
  @JsonKey(name: 'market_cap')
  final CoinMarketCapResponse marketCap;
  @JsonKey(name: 'total_volume')
  final CoinTotalVolumeResponse totalVolume;

  CoinMarketDataResponse({
    required this.currentPrice,
    required this.marketCap,
    required this.totalVolume,
  });

  factory CoinMarketDataResponse.fromJson(Map<String, dynamic> json) => _$CoinMarketDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinMarketDataResponseToJson(this);
}
