enum TimeRangeMode { oneWeek, oneMonth, sixMonth }

class TimeRangeModel {
  final TimeRangeMode mode;
  final String title;

  TimeRangeModel({required this.mode, required this.title});
}
