import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';

class IconButtonContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPress;
  const IconButtonContainer(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.neutralWhite, size: 30,),
          Text(
            title,
            style: AppTypography.headlineSemiBold
                .copyWith(color: AppColors.neutralWhite),
          ),
        ],
      ),
    );
  }
}
