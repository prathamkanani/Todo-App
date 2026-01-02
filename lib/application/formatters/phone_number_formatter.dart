import 'package:flutter/services.dart';

/// Input formatter for the user phone number.
class PhoneInputFormatter extends TextInputFormatter {
  final int maxLength;

  PhoneInputFormatter({required this.maxLength});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Gets only the numbers from the user input.
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Checks if the user input is not greater than max length.
    if (text.length > maxLength) {
      text = text.substring(0, maxLength);
    }

    // The field starts with a '+91'.
    if (text.isEmpty) return const TextEditingValue(text: '+');

    // Formats the mobile number in correct format.
    final StringBuffer buffer = StringBuffer('+');
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 4 || i == 9) buffer.write(' ');
    }

    // Correctly formatted string is returned to TextEditingValue
    final String formatted = buffer.toString().trimRight();

    return TextEditingValue(
      text: formatted,
    );
  }
}