import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/screens/widgets/containers/music_avatar_square_container.dart';

class SongVerticalSquareContainer extends StatelessWidget {
  final VoidCallback onPress;
  final Songs song;
  const SongVerticalSquareContainer(
      {super.key, required this.song, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 128,
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                MusicAvatarSquareContainer(
                  width: 128,
                  height: 128,
                  imageUrl: song.image!,
                ),
                Positioned(
                    right: 8,
                    bottom: 8,
                    child: ClipOval(
                      child: Container(
                        height: 20,
                        width: 20,
                        color: AppColors.neutralGray,
                        child: const Icon(
                          CupertinoIcons.play_arrow_solid,
                          color: AppColors.neutralWhite,
                          size: 14,
                        ),
                      ),
                    ))
              ],
            ),
            Text(song.title,
                style: AppTypography.bodySemiBold
                    .copyWith(color: AppColors.neutralWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(song.artist.join(", "),
                style: AppTypography.captionRegular
                    .copyWith(color: AppColors.neutralWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }
}
