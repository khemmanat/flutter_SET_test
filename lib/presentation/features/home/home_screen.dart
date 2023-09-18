import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/app_dependency_injection.dart';
import '../../../domain/entities/coin/coin_data.dart';
import '../../widgets/app_scaffold_view.dart';
import '../coin/coin_screen.dart';
import 'bloc/coin_bloc.dart';

/// Home screen of the app
/// Display list of coins
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final CoinBloc _coinBloc = injector.get<CoinBloc>();

  List<CoinData> searchCoinList = [];

  @override
  Widget build(BuildContext context) {
    return AppScaffoldView(
      body: BlocBuilder<CoinBloc, CoinState>(
        bloc: _coinBloc..add(FetchCoinListEvent()),
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
          } else if (state is CoinListLoadedState) {
            searchCoinList = state.coinList;
            return Column(
              children: [
                //search text field
                TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchCoinList = state.coinList
                          .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
                //list of coins
                Expanded(
                  child: ListView.builder(
                    itemCount: searchCoinList.length,
                    itemBuilder: (context, index) {
                      final coinData = searchCoinList[index];
                      return ListTile(
                        onTap: () => onCoinTap(id: coinData.id, coinName: coinData.name),
                        title: Text(coinData.name),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  void onCoinTap({required String id, required String coinName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoinScreen(
          coinName: coinName,
          coinId: id,
        ),
      ),
    );
  }
}
