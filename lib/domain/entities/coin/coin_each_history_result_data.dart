class CoinEachHistoryResultData {
  CoinEachHistoryResultData({
    required this.id,
    required this.symbol,
    required this.prevPrice,
    required this.currentPrice,
    this.priceChange,
    required this.prevMarketCap,
    required this.currentMarketCap,
    this.marketCapChange,
    required this.prevTotalVolume,
    required this.currentTotalVolume,
    this.totalVolumeChange,
  });

  final String id;
  final String symbol;

  final double prevPrice;
  final double currentPrice;
  final double? priceChange;
  final double prevMarketCap;
  final double currentMarketCap;
  final double? marketCapChange;
  final double prevTotalVolume;
  final double currentTotalVolume;
  final double? totalVolumeChange;
}
