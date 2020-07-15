import 'package:intl/intl.dart';

String formatNumber(int number) {
  final f = NumberFormat.decimalPattern();
  return f.format(number);
}

String convertSecondsToReadable(int seconds) {
  if (seconds == null) return '';
  var timeString = '';

  final numSeconds = seconds.floor();
  final numMinutes = (seconds / 60).floor();
  final numHours = (numMinutes / 60).floor();
  final numDays = (numHours / 24).floor();
  final numYears = (numDays / 365).floor();
  final numCenturies = (numYears / 100).floor();

  if (numSeconds == 0) {
    timeString = 'less than a seconds';
  } else if (numSeconds < 60) {
    timeString = '${formatNumber(numSeconds)} seconds';
  } else if (numMinutes < 60) {
    timeString = '${formatNumber(numMinutes)} minutes';
  } else if (numHours < 24) {
    timeString = '${formatNumber(numHours)} hours';
  } else if (numDays < 365) {
    timeString = '${formatNumber(numDays)} days';
  } else if (numYears < 100) {
    timeString = '${formatNumber(numYears)} years';
  } else {
    timeString = '${formatNumber(numCenturies)} centuries';
  }

  return timeString;
}
