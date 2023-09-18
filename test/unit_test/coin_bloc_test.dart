import 'package:flutter_set_test/data/datasource/remote/request/each_coin_history_request.dart';
import 'package:flutter_set_test/domain/entities/coin/cois_list_data.dart';
import 'package:flutter_set_test/domain/entities/coin/each_coin_history/each_coin_history_data.dart';
import 'package:flutter_set_test/domain/use_case/coin_list_use_case.dart';
import 'package:flutter_set_test/domain/use_case/get_each_coin_history_use_case.dart';
import 'package:flutter_set_test/presentation/features/home/bloc/coin_bloc.dart';
import 'package:flutter_set_test/util/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'coin_bloc_test.mocks.dart';

@GenerateMocks([
  CoinBloc,
  CoinListUseCase,
  GetEachCoinHistoryUseCase,
])
void main() {
  // test('Coin Bloc should call Coin Lists', () {});
  group('CoinBloC Test', () {
    late CoinBloc coinBloc;
    late MockGetEachCoinHistoryUseCase mockGetEachCoinHistoryUseCase;
    late MockCoinListUseCase mockCoinListUseCase;

    setUp(() => {
          mockGetEachCoinHistoryUseCase = MockGetEachCoinHistoryUseCase(),
          mockCoinListUseCase = MockCoinListUseCase(),
          coinBloc = CoinBloc(
            getEachCoinHistoryUseCase: mockGetEachCoinHistoryUseCase,
            coinListUseCase: mockCoinListUseCase,
          ),
        });

    tearDown(() => {
          coinBloc.close(),
        });

    test('Coin Bloc should call Coin Lists', () {
      when(mockCoinListUseCase.call()).thenAnswer((_) async => Right(CoinListData(coinList: [])));
      coinBloc.add(FetchCoinListEvent());
      verify(mockCoinListUseCase.call());
    });

    test('Coin Bloc should call Each Coin History', () {
      when(mockGetEachCoinHistoryUseCase.call(any)).thenAnswer((_) async => Right(EachCoinHistoryData()));
      coinBloc.add(FetchEachCoinHistoryEvent(id: '1'));
      EachCoinRequest request = EachCoinRequest(id: '1', date: '15-09-2023');
      verify(mockGetEachCoinHistoryUseCase.call(request));
    });
  });
}
