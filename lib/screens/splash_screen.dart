import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/viewmodel/auth_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final authViewModel = Provider.of<AuthViewmodel>(context, listen: false);
    // Kiểm tra trạng thái đăng nhập
    Future.delayed(const Duration(seconds: 1), () {
      if (authViewModel.currentUser != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RichText(
        text: TextSpan(
          text: 'Welcome ',
          style: AppTypography.titleBold.copyWith(color: AppColors.secondary),
          children: <TextSpan>[
            TextSpan(
                text: 'Sound MP3',
                style:
                    AppTypography.titleBold.copyWith(color: AppColors.primary)),
          ],
        ),
      )),
    );
  }
}
