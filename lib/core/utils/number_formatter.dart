import 'package:challenge/core/utils/validators.dart';
import 'package:flutter/services.dart';

/// only allows numbers in text fields
class NumberFormatter extends TextInputFormatter with Validator {
  String? previousText;
  int position = 0;
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.trim();

    if (newValue.selection.baseOffset == 0) return newValue;
    position = newValue.selection.baseOffset;
    text = formatText(text) ?? '';

    return newValue.copyWith(
        text: text, selection: TextSelection.collapsed(offset: text.length));
  }

  String? formatText(String text) {
    text = sanitizeNumber(text);
    int startOffset = 2;
    position = 0;
    var buffer = StringBuffer();
    if (text[0] == '0') startOffset = 3;
    for (int i = 0; i < text.length; i++) {
      if (numberRegExp.hasMatch(text[i])) {
        position++;
        buffer.write(text[i]);
      }
      if ((i == startOffset ||
              i == startOffset + 4 ||
              i == startOffset + 8 ||
              (startOffset == 2 && i == startOffset + 9)) &&
          i != text.length - 1) {
        position++;
        buffer.write(' ');
      }
    }
    return buffer.toString().trim();
  }

  /// remove characters from number
  String sanitizeNumber(String number) {
    String? text = number.trim();
    // text = text.replaceAll(RegExp(r'^\d+$'), '');
    text = text.replaceAll('-', '');
    text = text.replaceAll('(', '');
    text = text.replaceAll(')', '');
    text = text.replaceAll(' ', '');
    return text;
  }
}
