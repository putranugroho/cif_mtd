import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatters extends TextInputFormatter {
  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove all except digits, comma, dot
    String cleanedText = newText.replaceAll(RegExp(r'[^0-9.,]'), '');

    // Replace dot with comma (for Indonesian decimal)
    cleanedText = cleanedText.replaceAll('.', ',');

    // For parsing double → replace comma with dot
    String parseable = cleanedText.replaceAll(',', '.');

    double? value = double.tryParse(parseable);

    if (value != null) {
      String formatted = currencyFormatter.format(value);
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } else {
      return oldValue;
    }
  }
}
