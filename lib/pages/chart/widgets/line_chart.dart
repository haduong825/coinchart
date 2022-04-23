import 'package:chart_coin/domain/models/bitcoin.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartCoin extends StatefulWidget {
  final List<BitcoinModel> data;
  const LineChartCoin({Key? key, required this.data}) : super(key: key);

  @override
  _LineChartCoinState createState() => _LineChartCoinState();
}

class _LineChartCoinState extends State<LineChartCoin> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> dataChart = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dataChart = widget.data
        .asMap()
        .entries
        .map((e) => FlSpot(
              e.key.toInt().toDouble(),
              (e.value.value ?? 0).toInt().toDouble(),
            ))
        .toList();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final data = widget.data[value.toInt()];
    text = Text(
        value.toInt() % (dataChart.length > 7 ? (dataChart.length > 30 ? 29 : 5) : 1) == 0
            ? ('${data.date?.day} ${months[(data.date?.month ?? 1) - 1]}')
            : '',
        style: style);
    // text = Text('');
    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: dataChart.length > 7 ? 1000 : 100,
        verticalInterval: 10,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      ),
      // borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      borderData: FlBorderData(
          show: true,
          border: const Border(
              left: BorderSide(color: Color(0xff37434d), width: 1),
              bottom: BorderSide(color: Color(0xff37434d), width: 1))),
      // minX: 0,
      // maxX: 7000,
      // minY: 0,
      // maxY: 80000,
      lineBarsData: [
        LineChartBarData(
          spots: dataChart,
          isCurved: true,
          preventCurveOverShooting: true,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
