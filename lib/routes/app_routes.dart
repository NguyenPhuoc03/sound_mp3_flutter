// app_routes.dart
import 'package:sound_mp3/screens/artist_screen.dart';
import 'package:sound_mp3/screens/login_screen.dart';
import 'package:sound_mp3/screens/main_screen.dart';
import 'package:sound_mp3/screens/music_player_screen.dart';
import 'package:sound_mp3/screens/register_screen.dart';
import 'package:sound_mp3/screens/search_screen.dart';
import 'package:sound_mp3/screens/song_list_screen.dart';
import 'package:sound_mp3/screens/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash-screen';
  static const String loginScreen = '/login-screen';
  static const String registerScreen = '/register-screen';
  static const String mainScreen = '/main-screen';
  static const String musicPlayerScreen = '/music-player-screen';
  static const String songListScreen = '/song-list-screen';
  static const String artistScreen = '/artist-screen';
  static const String searchScreen = '/search-screen';
}

final appRoutes = {
  AppRoutes.splashScreen: (context) => SplashScreen(),
  AppRoutes.loginScreen: (context) => LoginScreen(),
  AppRoutes.registerScreen: (context) => RegisterScreen(),
  AppRoutes.mainScreen: (context) => MainScreen(),
  AppRoutes.musicPlayerScreen: (context) => MusicPlayerScreen(),
  AppRoutes.songListScreen: (context) => SongListScreen(),
  AppRoutes.artistScreen: (context) => ArtistScreen(),
  AppRoutes.searchScreen: (context) => SearchScreen(),
};
