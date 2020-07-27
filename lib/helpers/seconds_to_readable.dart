import 'package:intl/intl.dart';
import 'package:xcvbnm/xcvbnm.dart';

String formatNumber(int number) {
  final f = NumberFormat.decimalPattern();
  return f.format(number);
}

class PasswordStrength {
  final String message;
  final double strength;

  PasswordStrength({this.message, this.strength});
}

PasswordStrength getPasswordStrength(Result result) {
  if (result == null || result.crackTime == null || result.crackTime == 0) {
    return PasswordStrength(message: '', strength: 0);
  }
  final seconds = result.crackTime;
  var message = '';
  var strength = 0.0;

  final numSeconds = seconds.floor();
  final numMinutes = (seconds / 60).floor();
  final numHours = (numMinutes / 60).floor();
  final numDays = (numHours / 24).floor();
  final numYears = (numDays / 365).floor();
  final numCenturies = (numYears / 100).floor();

  if (numSeconds == 0) {
    message = 'less than a seconds';
    strength = 0.01;
  } else if (numSeconds < 60) {
    message = '${formatNumber(numSeconds)} seconds';
    strength = 0.1;
  } else if (numMinutes < 60) {
    message = '${formatNumber(numMinutes)} minutes';
    strength = 0.2;
  } else if (numHours < 24) {
    message = '${formatNumber(numHours)} hours';
    strength = 0.3;
  } else if (numDays < 365) {
    message = '${formatNumber(numDays)} days';
    numDays < 100 ? strength = 0.5 : strength = 0.6;
  } else if (numYears < 100) {
    message = '${formatNumber(numYears)} years';
    numYears < 10 ? strength = 0.65 : strength = 0.75;
  } else {
    message = '${formatNumber(numCenturies)} centuries';
    numCenturies < 100 ? strength = 0.85 : strength = 0.9;
    // Check if its over 100k centuries
    numCenturies > 100000 ? strength = 1.0 : strength;
  }

  return PasswordStrength(
    message: message,
    strength: strength,
  );
}
