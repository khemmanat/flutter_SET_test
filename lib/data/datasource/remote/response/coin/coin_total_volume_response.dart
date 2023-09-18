import 'package:json_annotation/json_annotation.dart';

part 'coin_total_volume_response.g.dart';

@JsonSerializable()
class CoinTotalVolumeResponse {
  final double usd;

  CoinTotalVolumeResponse({
    required this.usd,
  });

  factory CoinTotalVolumeResponse.fromJson(Map<String, dynamic> json) => _$CoinTotalVolumeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinTotalVolumeResponseToJson(this);
}
