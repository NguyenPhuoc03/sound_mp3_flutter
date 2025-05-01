import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/viewmodel/auth_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username')),
            TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: viewModel.isLoading
                  ? null
                  : () async {
                      final success = await viewModel.register(
                        _usernameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đăng ký thành công')),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginScreen, (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đăng ký thất bại')),
                        );
                      }
                    },
              child: viewModel.isLoading
                  ? CircularProgressIndicator()
                  : Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}
