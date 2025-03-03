import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/mvvm/auth_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final authViewModel = Provider.of<AuthViewmodel>(context, listen: false);
    await authViewModel.login(
      _emailOrUsernameController.text,
      _passwordController.text,
    );
    if (authViewModel.currentUser != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sound MP3",
          style: AppTypography.titleBold.copyWith(color: AppColors.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 32),
              child: Text(
                "LOGIN",
                style: AppTypography.titleBold
                    .copyWith(color: AppColors.neutralWhite),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If You Need Any Support",
                  style: AppTypography.captionRegular
                      .copyWith(color: AppColors.neutralWhite),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Click Here",
                    style: AppTypography.captionRegular
                        .copyWith(color: AppColors.primary),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailOrUsernameController,
                    style: AppTypography.captionSemiBold.copyWith(
                      color: AppColors.primary,
                    ),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      floatingLabelStyle:
                          AppTypography.captionSemiBold.copyWith(
                        color: AppColors.primary,
                      ),
                      focusColor: AppColors.primary,
                      labelText: 'Enter Username Or Email',
                      labelStyle: AppTypography.captionSemiBold.copyWith(
                        color: AppColors.neutralGray,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide:
                            const BorderSide(color: AppColors.neutralGray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    style: AppTypography.captionSemiBold.copyWith(
                      color: AppColors.primary,
                    ),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      floatingLabelStyle:
                          AppTypography.captionSemiBold.copyWith(
                        color: AppColors.primary,
                      ),
                      focusColor: AppColors.primary,
                      labelText: 'Password',
                      labelStyle: AppTypography.captionSemiBold.copyWith(
                        color: AppColors.neutralGray,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide:
                            const BorderSide(color: AppColors.neutralGray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {},
                child: Text("Forgot password?",
                    style: AppTypography.captionSemiBold.copyWith(
                      color: AppColors.neutralWhite,
                    )),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  'Log In',
                  style: AppTypography.titleBold.copyWith(
                    color: AppColors.neutralBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
