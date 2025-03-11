import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';

class EmptyDisplay extends StatelessWidget {
  final String message;

  const EmptyDisplay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.heart_broken_rounded,
                color: AppColors.primary, size: 36),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.headlineRegular
                  .copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
