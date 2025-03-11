import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/playlist_vertical_square_container.dart';

class PlaylistTab extends StatefulWidget {
  const PlaylistTab({super.key});

  @override
  State<PlaylistTab> createState() => _PlaylistTabState();
}

class _PlaylistTabState extends State<PlaylistTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          shadowColor: AppColors.neutralWhite.withOpacity(0.8),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
          title: Text(
            "Playlist",
            style:
                AppTypography.titleBold.copyWith(color: AppColors.neutralWhite),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 48,
            mainAxisSpacing: 32,
            childAspectRatio: 150 / 200,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return PlaylistVerticalSquareContainer();
          },
        ));
  }
}
