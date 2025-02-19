import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_mp3/screens/widgets/containers/playlist_horizontal_circle_container.dart';

class ArtistsTabBarView extends StatelessWidget {
  const ArtistsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 32, right: 16),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 40,
        itemBuilder: (context, index) {
          return PlaylistHorizontalCircleContainer();
        },
      ),
    );
  }
}
