import 'dart:math';

extension Format on DateTime {
  String get readableFormat {
    var date = toLocal();
    int year = date.year;
    String month = monthNames[max(min(date.month - 1, 13), 0)];
    int day = date.day;
    return '$month $day $year';
  }

  String get readableFormatMin {
    var date = toLocal();
    // int year = date.year;
    String month = monthNamesMin[max(min(date.month - 1, 13), 0)];
    int day = date.day;
    return '$month $day';
  }
}

const List<String> monthNames = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const List<String> monthNamesMin = <String>[
  'Jan',
  'Feb',
  'March',
  'April',
  'May',
  'June',
  'July',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
