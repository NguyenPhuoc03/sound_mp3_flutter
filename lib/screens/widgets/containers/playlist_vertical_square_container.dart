import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/avatar_square_container.dart';

class PlaylistVerticalSquareContainer extends StatelessWidget {
  const PlaylistVerticalSquareContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 150,
      // height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AvatarSquareContainer(
            imageUrl:
                'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
            hasShadow: true,
          ),
          Text("Ballad",
              style: AppTypography.bodySemiBold
                  .copyWith(color: AppColors.neutralWhite),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          Text("106 song",
              style: AppTypography.captionRegular
                  .copyWith(color: AppColors.neutralWhite),
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
