part of 'coin_bloc.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();

  @override
  List<Object> get props => [];
}

class FetchCoinListEvent extends CoinEvent {
  @override
  List<Object> get props => [];
}

class FetchEachCoinHistoryEvent extends CoinEvent {
  const FetchEachCoinHistoryEvent({required this.id});
  final String id;
  @override
  List<Object> get props => [];
}
