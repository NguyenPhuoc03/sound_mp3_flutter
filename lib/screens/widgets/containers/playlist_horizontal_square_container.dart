import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/music_avatar_square_container.dart';

class PlaylistHorizontalSquareContainer extends StatelessWidget {
  const PlaylistHorizontalSquareContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const MusicAvatarSquareContainer(
            width: 64,
            imageUrl:
                'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ArTi",
                    style: AppTypography.titleRegular
                        .copyWith(color: AppColors.neutralWhite),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text("title",
                    style: AppTypography.headlineRegular
                        .copyWith(color: AppColors.neutralWhite),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}