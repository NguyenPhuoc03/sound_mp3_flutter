// app_routes.dart
import 'package:sound_mp3/screens/main_screen.dart';
import 'package:sound_mp3/screens/music_player_screen.dart';

class AppRoutes {
  static const String mainScreen = '/main-screen';
  static const String musicPlayerScreen = '/music-player-screen';
}

final appRoutes = {
  AppRoutes.mainScreen: (context) => MainScreen(),
  AppRoutes.musicPlayerScreen: (context) => MusicPlayerScreen(),
};
