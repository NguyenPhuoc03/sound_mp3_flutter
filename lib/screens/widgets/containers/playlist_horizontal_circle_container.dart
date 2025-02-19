
import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/music_avatar_circle_container.dart';

class PlaylistHorizontalCircleContainer extends StatelessWidget {
  const PlaylistHorizontalCircleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      height: 80,
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const MusicAvatarCircleContainer(
                imageUrl:
                    'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
              ),
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ArTi",
                        style: AppTypography.titleRegular
                            .copyWith(color: AppColors.neutralWhite),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Text("43,875,999 monthly listeners",
                        style: AppTypography.captionRegular
                            .copyWith(color: AppColors.neutralWhite),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.neutralWhite,
              )),
        ],
      ),
    );
  }
}
