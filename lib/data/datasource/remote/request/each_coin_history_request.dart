import 'package:json_annotation/json_annotation.dart';

part 'each_coin_history_request.g.dart';

@JsonSerializable()
class EachCoinRequest {
  final String id;
  final String date;

  EachCoinRequest({
    required this.id,
    required this.date,
  });
}
