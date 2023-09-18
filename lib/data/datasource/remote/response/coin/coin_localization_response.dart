import 'package:json_annotation/json_annotation.dart';

part 'coin_localization_response.g.dart';

@JsonSerializable()
class CoinLocalizationResponse {
  CoinLocalizationResponse({
    required this.en,
  });
  final String en;

  factory CoinLocalizationResponse.fromJson(Map<String, dynamic> json) => _$CoinLocalizationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinLocalizationResponseToJson(this);
}
