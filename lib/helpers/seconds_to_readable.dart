import 'package:intl/intl.dart';

String formatNumber(double number) {
  final f = NumberFormat.decimalPattern();
  return f.format(number);
}

String convertSecondsToReadable(int seconds) {
  if (seconds == null) return '';
  var timeString = '';

  final numSeconds = seconds.floor().toDouble();
  final numMinutes = seconds.floor() / 60;
  final numHours = numMinutes.floor() / 60;
  final numDays = numHours.floor() / 24;
  final numYears = numDays.floor() / 365;
  final numCenturies = numYears.floor() / 100;

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
