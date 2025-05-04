import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatters extends TextInputFormatter {
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'en_US', // <-- gunakan en_US untuk comma ribuan, dot decimal
    symbol: 'Rp ',
    decimalDigits: 2,
  );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // 1️⃣ Hapus simbol mata uang
    text = text.replaceAll(currencyFormat.currencySymbol, '');

    // 2️⃣ Hapus spasi
    text = text.replaceAll(' ', '');

    // 3️⃣ Hapus comma ribuan (karena akan di-reformat nanti)
    text = text.replaceAll(',', '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double? value = double.tryParse(text);
    if (value == null) {
      return oldValue; // kalau parsing gagal, tetap pakai oldValue
    }

    String newText = currencyFormat.format(value);

    // Hitung posisi cursor baru
    int selectionIndex =
        newText.length - (oldValue.text.length - oldValue.selection.end);

    if (selectionIndex > newText.length) {
      selectionIndex = newText.length;
    } else if (selectionIndex < 0) {
      selectionIndex = 0;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
