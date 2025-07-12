import 'package:intl/intl.dart';

class DateUtils {
  static String formatDateTime(
    DateTime dateTime, {
    String format = 'yyyy-MM-dd HH:mm',
  }) {
    return DateFormat(format).format(dateTime);
  }

  static String formatDate(DateTime dateTime, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(dateTime);
  }

  static String formatTime(DateTime dateTime, {String format = 'HH:mm'}) {
    return DateFormat(format).format(dateTime);
  }

  static DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static DateTime endOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
  }
}
