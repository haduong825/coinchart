import 'package:chart_coin/domain/models/time_range_mode.dart';
import 'package:chart_coin/injection_container.dart';
import 'package:chart_coin/pages/chart/chart.dart';
import 'package:chart_coin/pages/chart/chart_event.dart';
import 'package:chart_coin/pages/chart/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final bloc = sl<ChartBloc>();

  late TimeRangeModel dropdownValue;
  late List<TimeRangeModel> listFilter;

  @override
  void initState() {
    listFilter = [
      TimeRangeModel(mode: TimeRangeMode.oneWeek, title: '1 Week'),
      TimeRangeModel(mode: TimeRangeMode.oneMonth, title: '1 Month'),
      TimeRangeModel(mode: TimeRangeMode.sixMonth, title: '6 Month')
    ];
    dropdownValue = listFilter.first;
    bloc.add(LoadCoinDataEvent(mode: dropdownValue.mode));
    super.initState();
  }

  _buildDropdownOption() {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 40,
      width: 150,
      child: DropdownButtonFormField(
        value: dropdownValue,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black45, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        onChanged: (TimeRangeModel? newValue) {
          if (newValue != null) {
            setState(() {
              dropdownValue = newValue;
            });
            bloc.add(LoadCoinDataEvent(mode: newValue.mode));
          }
        },
        items: listFilter.map<DropdownMenuItem<TimeRangeModel>>((TimeRangeModel value) {
          return DropdownMenuItem(
            value: value,
            child: Container(
              height: 48,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              // color: Constants.appLightGray2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value.title,
                    style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownOption(),
          Expanded(
            child: BlocBuilder<ChartBloc, CoinDataState>(
              builder: (context, state) {
                if (state is LoadedCoinDataState) {
                  return LineChartCoin(
                    data: state.data.toList(),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
