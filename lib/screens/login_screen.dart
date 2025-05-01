import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/viewmodel/auth_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hasError = false;
  String? _passwordError;
  final _formKey = GlobalKey<FormState>();
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final authViewModel = Provider.of<AuthViewmodel>(context, listen: false);
    final isValid = _formKey.currentState!.validate();
    setState(() {
      _hasError = !isValid;
    });
    if (isValid) {
      await authViewModel.login(
        _emailOrUsernameController.text,
        _passwordController.text,
      );

      // mat khau sai
      if (authViewModel.currentUser == null) {
        setState(() {
          _passwordError = 'Password is incorrect';
        });
      } else {
        setState(() {
          _passwordError = null;
        });
        Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
      }
    }
  }

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Sound MP3",
            style: AppTypography.titleBold.copyWith(color: AppColors.primary),
          ),
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
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
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailOrUsernameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      if (_hasError && value.trim().isNotEmpty) {
                        setState(() {
                          _hasError = false;
                        });
                      }
                    },
                    style: AppTypography.captionSemiBold.copyWith(
                      color: AppColors.primary,
                    ),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter username or email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      if (_hasError && value.trim().isNotEmpty) {
                        setState(() {
                          _hasError = false;
                        });
                      }
                    },
                    style: AppTypography.captionSemiBold.copyWith(
                      color: AppColors.primary,
                    ),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusColor: AppColors.primary,
                      labelText: 'Password',
                      errorText: _passwordError,
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
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
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "You do not have an account?",
                    style: AppTypography.captionSemiBold.copyWith(
                      color: AppColors.neutralWhite,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.registerScreen);
                    },
                    child: Text(
                      "Click Here",
                      style: AppTypography.captionRegular
                          .copyWith(color: AppColors.primary),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
