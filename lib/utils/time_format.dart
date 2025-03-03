// convert duration in to mm:ss
String formatTime(Duration duration) {
  String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
  return formattedTime;
}
