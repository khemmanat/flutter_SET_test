part of 'coin_bloc.dart';

abstract class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object> get props => [];
}

class CoinInitial extends CoinState {
  @override
  List<Object> get props => [];
}

class CoinLoadingState extends CoinState {
  @override
  List<Object> get props => [];
}

class CoinListLoadedState extends CoinState {
  const CoinListLoadedState({required this.coinList});
  final List<CoinData> coinList;

  @override
  List<Object> get props => [coinList];
}

class CoinListErrorState extends CoinState {
  const CoinListErrorState({required this.message});
  final String message;
  @override
  List<Object> get props => [];
}

class CoinEachLoadedState extends CoinState {
  const CoinEachLoadedState({required this.coinData});
  final CoinEachHistoryResultData coinData;

  @override
  List<Object> get props => [coinData];
}

class CoinEachErrorState extends CoinState {
  const CoinEachErrorState({required this.message});
  final String message;

  @override
  List<Object> get props => [];
}
