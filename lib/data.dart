import 'package:intl/intl.dart';

class data {
  static String todatetime(DateTime datetime) {
    final date = DateFormat.yMd().format(datetime);
    final time = DateFormat.Hm().format(datetime);

    return '$date $time';
  }

  static String todate(DateTime datetime) {
    final date = DateFormat.yMd().format(datetime);
    return '$date';
  }

  static String totime(DateTime datetime) {
    final time = DateFormat.Hm().format(datetime);
    return '$time';
  }

}