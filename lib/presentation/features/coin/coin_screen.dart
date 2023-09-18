import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_set_test/presentation/widgets/app_scaffold_view.dart';

import '../../../common/di/app_dependency_injection.dart';
import '../home/bloc/coin_bloc.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key, required this.coinName, required this.coinId});

  final String coinName;
  final String coinId;

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  final CoinBloc _coinBloc = injector.get<CoinBloc>();

  @override
  Widget build(BuildContext context) {
    return AppScaffoldView(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.coinName),
        ),
        body: BlocBuilder<CoinBloc, CoinState>(
          bloc: _coinBloc..add(FetchEachCoinHistoryEvent(id: widget.coinId)),
          builder: (context, state) {
            log('state: $state');
            if (state is CoinInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CoinLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CoinEachLoadedState) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(children: [
                            const Text("Prev. Price"),
                            Text(state.coinData.prevPrice.toString()),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(children: [
                            const Text("Price"),
                            Text(state.coinData.currentPrice.toString()),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Column(children: [
                            const Text("% Change"),
                            Text(state.coinData.priceChange.toString(),
                                style: TextStyle(color: checkValueFromValue(state.coinData.priceChange ?? 0))),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(children: [
                            const Text("Prev. Market Cap"),
                            Text(state.coinData.prevMarketCap.toString()),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(children: [
                            const Text("Market Cap"),
                            Text(state.coinData.currentMarketCap.toString()),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Column(children: [
                            const Text("% Change"),
                            Text(state.coinData.marketCapChange.toString(),
                                style: TextStyle(color: checkValueFromValue(state.coinData.marketCapChange ?? 0))),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(children: [
                            const Text("Prev. Volume"),
                            Text(
                              state.coinData.prevTotalVolume.toString(),
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(children: [
                            const Text("Volume"),
                            Text(state.coinData.currentTotalVolume.toString()),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Column(children: [
                            const Text("% Change"),
                            Text(state.coinData.totalVolumeChange.toString(),
                                style: TextStyle(color: checkValueFromValue(state.coinData.totalVolumeChange ?? 0))),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ));
  }

  Color checkValueFromValue(double value) {
    if (value > 0) {
      return Colors.green;
    } else if (value < 0) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}
