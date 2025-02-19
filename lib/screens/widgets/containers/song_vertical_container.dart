import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/loading_container.dart';

class SongVerticalContainer extends StatelessWidget {
  const SongVerticalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 128,
                width: 128,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp",
                    placeholder: (context, url) => const LoadingContainer(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
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
          Text("ArTi Untuk Cinta",
              style: AppTypography.bodySemiBold
                  .copyWith(color: AppColors.neutralWhite),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          Text("Arsy Widianto, fffffffffffff",
              style: AppTypography.captionRegular
                  .copyWith(color: AppColors.neutralWhite),
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
