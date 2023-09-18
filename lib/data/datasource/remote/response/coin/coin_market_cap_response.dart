import 'package:json_annotation/json_annotation.dart';

part 'coin_market_cap_response.g.dart';

@JsonSerializable()
class CoinMarketCapResponse {
  final double usd;

  CoinMarketCapResponse({
    required this.usd,
  });

  factory CoinMarketCapResponse.fromJson(Map<String, dynamic> json) => _$CoinMarketCapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinMarketCapResponseToJson(this);
}
