import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_mp3/screens/widgets/containers/loading_container.dart';

class MusicAvatarCircleContainer extends StatelessWidget {
  final int radius;
  final String imageUrl;
  const MusicAvatarCircleContainer(
      {super.key, this.radius = 40, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const LoadingContainer(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
