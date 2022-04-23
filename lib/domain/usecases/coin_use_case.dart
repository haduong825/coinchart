import 'package:chart_coin/domain/models/bitcoin.dart';
import 'package:chart_coin/domain/repositories/coin_repository.dart';

class CoinUseCase {
  final CoinRepository repository;

  CoinUseCase(this.repository);

  Future<List<BitcoinModel>> getBitcoinData() => repository.getBitcoinData();
}
