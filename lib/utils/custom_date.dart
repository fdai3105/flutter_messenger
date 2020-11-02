part of 'utils.dart';
class CustomDateTime {

  static String customDateTime(int _dateTimeS) {
    // case String to DateTime
    final _dateTime = DateTime.fromMillisecondsSinceEpoch(_dateTimeS);
    final _nowDate = DateTime.now();
    final _time = DateFormat("h:mm a").format(_dateTime);
    final _differenceDay = _nowDate.difference(_dateTime).inDays;

    if (_dateTime.day == _nowDate.day &&
        sameMonthYear(_dateTime.month, _dateTime.year)) {
      return "Today $_time";
    } else if (_dateTime.day == _nowDate.day - 1 &&
        sameMonthYear(_dateTime.month, _dateTime.year)) {
      return "Yesterday $_time";
    } else if (_dateTime.day == _nowDate.day - 2 &&
        sameMonthYear(_dateTime.month, _dateTime.year)) {
      return "2 day ago $_time";
    } else if (_differenceDay <= DateTime.daysPerWeek) {
      return "$_differenceDay days ago $_time";
    } else {
      return "$_dateTime";
    }
  }

  static bool sameMonthYear(int month, int year) {
    // check is same month and year
    final _now = DateTime.now();
    if (month == _now.month && year == _now.year) {
      return true;
    }
    return false;
  }

}
