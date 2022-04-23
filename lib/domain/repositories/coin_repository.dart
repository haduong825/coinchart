import 'dart:convert';

import 'package:chart_coin/core/error/exception.dart';
import 'package:chart_coin/domain/models/bitcoin.dart';
import 'package:flutter/services.dart';

abstract class CoinRepository {
  Future<List<BitcoinModel>> getBitcoinData();
}

class CoinRepositoryImpl implements CoinRepository {
  @override
  Future<List<BitcoinModel>> getBitcoinData() async {
    try {
      final String dataJson = await rootBundle.loadString('assets/data.json');
      BitCoinModelResponse response = BitCoinModelResponse.fromJson(json.decode(dataJson));
      return (response.data ?? []).where((element) => element.value != 0).toList();
    } on Exception {
      throw MappingException();
    }
  }
}
