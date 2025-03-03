import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/theme.dart';
import 'package:sound_mp3/mvvm/auth_viewmodel.dart';
import 'package:sound_mp3/mvvm/music_player_viewmodel.dart';
import 'package:sound_mp3/mvvm/songs_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewmodel()),
        ChangeNotifierProvider(create: (_) => SongsViewmodel()),
        ChangeNotifierProvider(create: (_) => MusicPlayerViewmodel()),
      ],
      child: const MyApp(),
    ),
  );
}

class SongViewModel {
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound MP3',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      //initialRoute: AppRoutes.mainScreen,
      initialRoute: AppRoutes.splashScreen,
      routes: appRoutes,
    );
  }
}
