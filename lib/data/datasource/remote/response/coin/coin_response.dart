import 'package:json_annotation/json_annotation.dart';

part 'coin_response.g.dart';

@JsonSerializable()
class CoinResponse {
  CoinResponse({
    required this.id,
    required this.symbol,
    required this.name,
  });
  final String id;
  final String symbol;
  final String name;

  factory CoinResponse.fromJson(Map<String, dynamic> json) => _$CoinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinResponseToJson(this);
}
