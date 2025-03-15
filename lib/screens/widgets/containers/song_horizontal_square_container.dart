import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/screens/widgets/containers/avatar_square_container.dart';

class SongHorizontalSquareContainer extends StatelessWidget {
  final VoidCallback onPress;
  final Songs song;
  const SongHorizontalSquareContainer({super.key, required this.song, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AvatarSquareContainer(
              width: 64,
              height: 64,
              imageUrl: song.image!,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(song.title,
                      style: AppTypography.titleRegular
                          .copyWith(color: AppColors.neutralWhite),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text(song.artist.join(", "),
                      style: AppTypography.headlineRegular
                          .copyWith(color: AppColors.neutralWhite),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: AppColors.neutralWhite,
                )),
          ],
        ),
      ),
    );
  }
}
