import 'package:chart_coin/domain/models/time_range_mode.dart';

abstract class CoinDataEvent {
  const CoinDataEvent();
}

class LoadCoinDataEvent extends CoinDataEvent {
  final TimeRangeMode mode;

  LoadCoinDataEvent({required this.mode});
}
