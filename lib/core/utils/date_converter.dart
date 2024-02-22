import 'package:intl/intl.dart';

class Utils {
  String formatDate(String rawDate) {
    DateTime date = DateTime.parse(rawDate);
    DateFormat formatter = DateFormat('dd MMMM yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  String formatDateAndTime(String rawDate) {
    DateTime date = DateTime.parse(rawDate);
    DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy HH:mm:ss');
    String formattedDateAndTime = formatter.format(date);
    return formattedDateAndTime;
  }
}
