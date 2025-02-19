import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/loading_container.dart';

class PlaylistVerticalContainer extends StatelessWidget {
  const PlaylistVerticalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      // width: 150,
      // height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neutralWhite.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl:
                    "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp",
                placeholder: (context, url) => const LoadingContainer(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
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
