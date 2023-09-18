import 'coin_image_data.dart';
import 'coin_localization_data.dart';
import 'coin_market_data_data.dart';

class EachCoinHistoryData {
  EachCoinHistoryData({
    this.error,
    this.id,
    this.symbol,
    this.name,
    this.localization,
    this.image,
    this.marketData,
  });

  final String? error;
  final String? id;
  final String? symbol;
  final String? name;
  final CoinLocalizationData? localization;
  final CoinImageData? image;
  final CoinMarketDataData? marketData;
}
