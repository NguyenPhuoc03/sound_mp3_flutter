import 'package:flutter/cupertino.dart';
import 'package:sound_mp3/configs/typography.dart';

class MusicCategoryTabBar extends StatelessWidget {
  final String title;
  final double? width;
  const MusicCategoryTabBar({
    super.key,
    required this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
          width: width ?? 75,
          child: Center(
            child: Text(title,
                style: AppTypography.titleSemiBold), 
          )),
    );
  }
}
