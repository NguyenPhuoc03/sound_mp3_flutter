import 'package:intl/intl.dart';

// convert duration in to mm:ss
String formatTimerPlaying(Duration duration) {
  String twoDigitSeconds =
      duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
  return formattedTime;
}

// convert DateTime to yyy-MM-dd
String formatDateYMD(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}
