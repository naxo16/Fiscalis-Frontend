import 'package:flutter/services.dart';

class RutFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9kK]'), '');
    if (text.isEmpty) return newValue.copyWith(text: '');
    String dv = text.substring(text.length - 1).toUpperCase();
    String body = text.substring(0, text.length - 1);
    
    String formattedBody = '';
    for (int i = body.length - 1, j = 1; i >= 0; i--, j++) {
      formattedBody = body[i] + formattedBody;
      if (j % 3 == 0 && i != 0) {
        formattedBody = '.$formattedBody';
      }
    }
    String result = formattedBody.isEmpty ? dv : '$formattedBody-$dv';
    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}

class PpuFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.toUpperCase().replaceAll('-', '');
    if (text.length > 6) text = text.substring(0, 6);
    if (text.length > 4) {
      text = '${text.substring(0, 4)}-${text.substring(4)}';
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
