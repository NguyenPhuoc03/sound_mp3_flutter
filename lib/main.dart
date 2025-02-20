import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/theme.dart';
import 'package:sound_mp3/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound MP3',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.mainScreen,
      routes: appRoutes,
    );
  }
}
