import 'package:chart_coin/domain/models/bitcoin.dart';
import 'package:chart_coin/domain/repositories/coin_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSuccessRepository implements CoinRepository {
  @override
  Future<List<BitcoinModel>> getBitcoinData() {
    return Future.value([BitcoinModel()]);
  }
}

void main() {
  late CoinRepository repository;

  setUp(() {
    repository = FakeSuccessRepository();
  });

  test('Test Coin Repository', () async {
    final result = await repository.getBitcoinData();
    expect(result.isNotEmpty, true);
  });
}
