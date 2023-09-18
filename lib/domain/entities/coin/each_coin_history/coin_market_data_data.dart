import 'coin_current_price_data.dart';
import 'coin_market_cap_data.dart';
import 'coin_total_volume_data.dart';

class CoinMarketDataData {
  final CoinCurrentPriceData currentPrice;
  final CoinMarketCapData marketCap;
  final CoinTotalVolumeData totalVolume;

  CoinMarketDataData({
    required this.currentPrice,
    required this.marketCap,
    required this.totalVolume,
  });
}
