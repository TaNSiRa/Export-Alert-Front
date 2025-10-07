// ignore_for_file: file_names

import 'package:intl/intl.dart';

String formatDateTime(String input) {
  if (input.isNotEmpty) {
    DateTime dateTime = DateTime.parse(input);
    String formatted = DateFormat('dd-MM-yy HH:mm').format(dateTime);
    return formatted;
  } else {
    return '';
  }
}

String formatDate(String input) {
  if (input.isNotEmpty) {
    DateTime dateTime = DateTime.parse(input);
    String formatted = DateFormat('dd-MM-yy').format(dateTime);
    return formatted;
  } else {
    return '';
  }
}
