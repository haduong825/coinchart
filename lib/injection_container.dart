import 'dart:ffi';

import 'package:chart_coin/domain/repositories/coin_repository.dart';
import 'package:chart_coin/domain/usecases/coin_use_case.dart';
import 'package:chart_coin/pages/chart/chart.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ChartBloc(useCase: sl()));
  sl.registerLazySingleton(() => CoinUseCase(sl()));
  sl.registerLazySingleton<CoinRepository>(() => CoinRepositoryImpl());
}
