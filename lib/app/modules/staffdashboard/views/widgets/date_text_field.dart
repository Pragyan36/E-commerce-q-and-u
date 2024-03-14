import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newString = '';
    int selectionIndex = newValue.selection.baseOffset;
    int usedSubstringIndex = 0;
    for (int i = 0; i < newValue.text.length; i++) {
      if (i == 4 || i == 7) {
        newString += '-';
        if (newValue.selection.baseOffset >= i) {
          selectionIndex++;
        }
      } else {
        if (usedSubstringIndex >= newValue.selection.baseOffset) {
          selectionIndex--;
        }
        usedSubstringIndex = i + 1;
      }
      newString += newValue.text[i];
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}