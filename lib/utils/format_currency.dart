import 'package:intl/intl.dart';

class FormatCurrency {
  static var oCcy = NumberFormat('#,##0', 'ID');
  static var oCcyDecimal = NumberFormat('#,##0.00', 'ID');
}

double roundTo1DecimalCustom(double value) {
  String valueStr = value.toStringAsFixed(2); // Pastikan 2 digit desimal
  List<String> parts = valueStr.split('.');

  int firstDecimal = int.parse(parts[1][0]);
  int secondDecimal = int.parse(parts[1][1]);

  double result;

  if (secondDecimal <= 5) {
    result = double.parse('${parts[0]}.$firstDecimal');
  } else {
    if (firstDecimal == 9) {
      // contoh: 9.96 → 10.0
      result = double.parse((value + 0.1).toStringAsFixed(1));
    } else {
      result = double.parse('${parts[0]}.${firstDecimal + 1}');
    }
  }

  return result;
}

String formatRounded(double value) {
  final formatter = NumberFormat('#,##0.00', 'ID');
  double rounded = roundTo1DecimalCustom(value);
  return formatter.format(rounded);
}
