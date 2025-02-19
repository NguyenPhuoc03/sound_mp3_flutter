import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/screens/widgets/containers/loading_container.dart';

class MusicAvatarSquareContainer extends StatelessWidget {
  final double width;
  final String imageUrl;
  final bool hasShadow;
  final double borderRadius;
  final Color color;
  const MusicAvatarSquareContainer(
      {super.key,
      this.width = 150,
      required this.imageUrl,
      this.hasShadow = false,
      this.borderRadius = 12,
      this.color = AppColors.neutralWhite});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 4,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const LoadingContainer(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
