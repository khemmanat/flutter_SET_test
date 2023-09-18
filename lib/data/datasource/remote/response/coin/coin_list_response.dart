import 'package:json_annotation/json_annotation.dart';

import 'coin_response.dart';

part 'coin_list_response.g.dart';

@JsonSerializable()
class CoinListResponse {
  CoinListResponse({
    required this.coinList,
  });

  final List<CoinResponse> coinList;

  factory CoinListResponse.fromJson(Map<String, dynamic> json) => _$CoinListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinListResponseToJson(this);
}
