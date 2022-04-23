import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class BitCoinModelResponse {
  BitCoinModelResponse({
    this.data,
  });

  factory BitCoinModelResponse.fromJson(Map<String, dynamic> jsonRes) {
    final List<BitcoinModel>? data = jsonRes['data'] is List ? <BitcoinModel>[] : null;
    if (data != null) {
      for (final dynamic item in jsonRes['data']!) {
        if (item != null) {
          data.add(BitcoinModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return BitCoinModelResponse(
      data: data,
    );
  }

  List<BitcoinModel>? data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
      };

  BitCoinModelResponse copy() {
    return BitCoinModelResponse(
      data: data?.map((BitcoinModel e) => e.copy()).toList(),
    );
  }
}

class BitcoinModel {
  BitcoinModel({this.dateStr, this.value, this.date});

  factory BitcoinModel.fromJson(Map<String, dynamic> jsonRes) => BitcoinModel(
      dateStr: asT<String?>(jsonRes['date']),
      value: asT<double?>(jsonRes['value']),
      date: DateTime.parse(asT<String?>(jsonRes['date']) ?? ''));

  String? dateStr;
  double? value;
  DateTime? date;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': dateStr,
        'value': value,
      };

  BitcoinModel copy() {
    return BitcoinModel(
      dateStr: dateStr,
      value: value,
    );
  }
}
