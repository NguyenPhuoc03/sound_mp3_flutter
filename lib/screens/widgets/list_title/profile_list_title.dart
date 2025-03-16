import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';

class ProfileListTitle extends StatelessWidget {
  final IconData iconLeading;
  final String title;
  IconData? iconTrailing;
  final VoidCallback onPress;
  ProfileListTitle(
      {super.key,
      required this.iconLeading,
      required this.title,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      shape: const Border(
        bottom: BorderSide(color: AppColors.neutralGray, width: 0.5),
      ),
      leading: Icon(iconLeading, color: AppColors.neutralWhite),
      title: Text(
        title,
        style: AppTypography.headlineRegular
            .copyWith(color: AppColors.neutralWhite),
      ),
      trailing: Icon(iconTrailing ?? Icons.arrow_forward_ios,
          color: AppColors.neutralWhite),
    );
  }
}
