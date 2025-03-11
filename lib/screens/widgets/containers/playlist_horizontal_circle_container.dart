import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/data/models/artists.dart';
import 'package:sound_mp3/data/models/albums.dart';
import 'package:sound_mp3/screens/widgets/containers/avatar_circle_container.dart';
import 'package:sound_mp3/screens/widgets/other/error_display.dart';

class PlaylistHorizontalCircleContainer<T> extends StatelessWidget {
  final T data;
  final VoidCallback onPress;
  const PlaylistHorizontalCircleContainer({
    super.key,
    required this.data,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    if (data is Artists) {
      final artist = data as Artists;
      return _buildArtistContainer(artist);
    } else if (data is Albums) {
      final album = data as Albums;
      return _buildAlbumContainer(album);
    } else {
      return ErrorDisplay(
          message: 'Unsupported data type: ${data.runtimeType}');
    }
  }

  Widget _buildArtistContainer(Artists artist) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        height: 80,
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AvatarCircleContainer(
                  radius: 32,
                  imageUrl: artist.avatar!,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(artist.name,
                          style: AppTypography.titleRegular
                              .copyWith(color: AppColors.neutralWhite),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text("${artist.interested} people interested",
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
      ),
    );
  }

  Widget _buildAlbumContainer(Albums album) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        height: 80,
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AvatarCircleContainer(
                  radius: 32,
                  imageUrl: album.image!,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(album.title!,
                          style: AppTypography.titleRegular
                              .copyWith(color: AppColors.neutralWhite),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text("${album.interested} people interested",
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
      ),
    );
  }
}
