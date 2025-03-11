import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarCircleContainer extends StatelessWidget {
  final double radius;
  final String imageUrl;
  const AvatarCircleContainer(
      {super.key, this.radius = 40.0, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          //placeholder: (context, url) => const LoadingContainer(),
          errorWidget: (context, url, error) =>
              Image.asset("assets/music_note_image.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
