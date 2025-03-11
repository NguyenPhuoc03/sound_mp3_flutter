import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';

class LoadingDisplay extends StatelessWidget {
  const LoadingDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}
