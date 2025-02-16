import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(42),
      child: const CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
