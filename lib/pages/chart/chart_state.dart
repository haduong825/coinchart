import 'package:chart_coin/domain/models/bitcoin.dart';

abstract class CoinDataState {
  const CoinDataState();
}

class InitialCoinDataState extends CoinDataState {}

class LoadingCoinDataState extends CoinDataState {}

class FailedCoinDataState extends CoinDataState {}

class LoadedCoinDataState extends CoinDataState {
  final List<BitcoinModel> data;

  LoadedCoinDataState(this.data);
}
