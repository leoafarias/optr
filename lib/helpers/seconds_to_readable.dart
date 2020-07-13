String convertSecondsToReadable(seconds) {
  if (seconds == null) return '';
  var timeString = '';

  // Enumerate all the numbers
  final numMilliseconds = seconds * 1000;
  final numSeconds = seconds.floor();
  final numMinutes = (numSeconds / 60).floor();
  final numHours = (numSeconds / (60 * 60)).floor();
  final numDays = (numSeconds / (60 * 60 * 24)).floor();
  final numYears = (numSeconds / (60 * 60 * 24 * 365)).floor();
  final numCenturies = (numSeconds / (60 * 60 * 24 * 365 * 100)).floor();

  if (numMilliseconds < 1000) {
    timeString = '$timeString $numMilliseconds milliseconds';
  } else if (numSeconds < 60) {
    timeString = '$numSeconds seconds';
  } else if (numMinutes < 60) {
    timeString = '$numMinutes minutes';
  } else if (numHours < 24) {
    timeString = '$numHours hours';
  } else if (numDays < 365) {
    timeString = '$numDays days';
  } else if (numYears < 100) {
    timeString = '$numYears years';
  } else {
    timeString = '$numCenturies centuries';
  }
  return timeString.replaceAll(RegExp('/\B(?=(\d{3})+(?!\d))/g'), ',');
}
