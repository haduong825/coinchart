import 'dart:async';

import 'package:chart_coin/domain/models/bitcoin.dart';
import 'package:chart_coin/domain/models/time_range_mode.dart';
import 'package:chart_coin/domain/usecases/coin_use_case.dart';
import 'package:chart_coin/pages/chart/chart_event.dart';
import 'package:chart_coin/pages/chart/chart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartBloc extends Bloc<CoinDataEvent, CoinDataState> {
  final CoinUseCase useCase;

  ChartBloc({required this.useCase}) : super(InitialCoinDataState()) {
    on<CoinDataEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(CoinDataEvent event, Emitter<CoinDataState> emit) async {
    if (event is LoadCoinDataEvent) {
      try {
        emit(LoadingCoinDataState());
        final data = await loadData(event.mode);
        emit(LoadedCoinDataState(data.reversed.toList()));
      } catch (e) {
        emit(FailedCoinDataState());
      }
    }
  }

  Future<List<BitcoinModel>> loadData(TimeRangeMode mode) async {
    final response = await useCase.getBitcoinData();
    switch (mode) {
      case TimeRangeMode.oneWeek:
        return response.take(7).toList();
      case TimeRangeMode.oneMonth:
        return response.take(30).toList();
      case TimeRangeMode.sixMonth:
        return response.take(180).toList();
    }
  }
}
