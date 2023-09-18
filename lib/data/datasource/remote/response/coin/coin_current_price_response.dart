import 'package:json_annotation/json_annotation.dart';

part 'coin_current_price_response.g.dart';

@JsonSerializable()
class CoinCurrentPriceResponse {
  final double usd;

  CoinCurrentPriceResponse({
    required this.usd,
  });

  factory CoinCurrentPriceResponse.fromJson(Map<String, dynamic> json) => _$CoinCurrentPriceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinCurrentPriceResponseToJson(this);
}
