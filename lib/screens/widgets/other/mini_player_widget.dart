import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/viewmodel/music_player_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/screens/widgets/containers/avatar_circle_container.dart';

class MiniPlayerWidget extends StatelessWidget {
  final MiniplayerController controller;

  const MiniPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerViewmodel>(
      builder: (context, musicPlayer, child) {
        if (musicPlayer.currentIndex == null) return const SizedBox.shrink();

        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Miniplayer(
            controller: controller,
            minHeight: 70,
            maxHeight: 70,
            builder: (height, percentage) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.musicPlayerScreen);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  color: AppColors.neutralBlack,
                  height: height,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AvatarCircleContainer(
                        imageUrl:
                            musicPlayer.playlist[musicPlayer.currentIndex!].image!,
                        radius: 28,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              musicPlayer.playlist[musicPlayer.currentIndex!].title,
                              style: AppTypography.headlineRegular.copyWith(
                                color: AppColors.neutralWhite,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              musicPlayer.playlist[musicPlayer.currentIndex!].artist
                                  .join(","),
                              style: AppTypography.bodyRegular.copyWith(
                                color: AppColors.neutralWhite,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: musicPlayer.pauseOrResume,
                        icon: Icon(
                          musicPlayer.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: AppColors.primary,
                          size: 48,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onDismiss: () {
              musicPlayer.stop();
            },
          ),
        );
      },
    );
  }
}
