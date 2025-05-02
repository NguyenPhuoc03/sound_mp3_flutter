import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/utils/validators.dart';
import 'package:sound_mp3/viewmodel/auth_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _hasError = false;
  final _formRegisterKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register() async {
    final authViewModel = Provider.of<AuthViewmodel>(context, listen: false);
    final isValid = _formRegisterKey.currentState!.validate();
    setState(() {
      _hasError = !isValid;
    });
    if (isValid) {
      final result = await authViewModel.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (!result) {
        await Flushbar(
          title: 'Registration Failed',
          duration: const Duration(seconds: 3),
          message: "Something went wrong. Please try again.",
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      } else {
        await Flushbar(
          title: 'Registration successful',
          message: 'Your account has been created',
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.loginScreen, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sound MP3",
          style: AppTypography.titleBold.copyWith(color: AppColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            Form(
              key: _formRegisterKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 32),
                    child: Text(
                      "REGISTER",
                      style: AppTypography.titleBold
                          .copyWith(color: AppColors.neutralWhite),
                    ),
                  ),
                  //name
                  TextFormField(
                    controller: _nameController,
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
                      labelText: 'Enter Username',
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
                    validator: (value) => Validators.validateName(value),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // email
                  TextFormField(
                    controller: _emailController,
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
                      labelText: 'Email',
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
                    validator: (value) => Validators.validateEmail(value),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //password
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
                    obscureText: true,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
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
                    validator: (value) => Validators.validatePassword(value),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Register',
                          style: AppTypography.titleBold.copyWith(
                            color: AppColors.neutralBlack,
                          ),
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
