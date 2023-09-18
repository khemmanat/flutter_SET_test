import 'package:json_annotation/json_annotation.dart';

part 'coin_image_response.g.dart';

@JsonSerializable()
class CoinImageResponse {
  CoinImageResponse({
    required this.thumb,
    required this.small,
  });

  final String thumb;
  final String small;

  factory CoinImageResponse.fromJson(Map<String, dynamic> json) => _$CoinImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinImageResponseToJson(this);
}
