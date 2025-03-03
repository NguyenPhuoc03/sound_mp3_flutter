// app_routes.dart
import 'package:sound_mp3/screens/login_screen.dart';
import 'package:sound_mp3/screens/main_screen.dart';
import 'package:sound_mp3/screens/music_player_screen.dart';
import 'package:sound_mp3/screens/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash-screen';
  static const String loginScreen = '/login-screen';
  static const String mainScreen = '/main-screen';
  static const String musicPlayerScreen = '/music-player-screen';
}

final appRoutes = {
  AppRoutes.splashScreen: (context) => SplashScreen(),
  AppRoutes.loginScreen: (context) => LoginScreen(),
  AppRoutes.mainScreen: (context) => MainScreen(),
  AppRoutes.musicPlayerScreen: (context) => MusicPlayerScreen(),
};
