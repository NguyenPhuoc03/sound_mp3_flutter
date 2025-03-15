// convert duration in to mm:ss
import 'package:intl/intl.dart';

String formatTime(Duration duration) {
  String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
  return formattedTime;
}

String formatDateYMD(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}
