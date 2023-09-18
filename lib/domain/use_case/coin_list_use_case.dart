import 'dart:developer';

import 'package:flutter_set_test/domain/entities/coin/cois_list_data.dart';

import '../../util/either.dart';
import '../../util/service_exception.dart';
import '../repository/coin_repository.dart';

class CoinListUseCase {
  late CoinRepository _coinRepository;

  CoinListUseCase({required CoinRepository coinRepository}) {
    _coinRepository = coinRepository;
  }

  Future<Either<ServiceException, CoinListData>> call() async {
    log('CoinListUseCase');
    return await _coinRepository.getCoinList();
  }
}
