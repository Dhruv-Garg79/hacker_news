import 'package:intl/intl.dart';

class CommonFunc {
  static String formattedDateTime(String str) {
    final date = DateTime.parse(str);
    return DateFormat("dd MMM yyyy • hh:mm").format(date);
  }
}
