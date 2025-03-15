import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/viewmodel/music_player_viewmodel.dart';
import 'package:sound_mp3/screens/widgets/containers/avatar_circle_container.dart';
import 'package:sound_mp3/utils/time_format.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    double? displayValue;
    return Scaffold(
      backgroundColor: AppColors.neutralGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Now Playing",
          style:
              AppTypography.titleBold.copyWith(color: AppColors.neutralWhite),
        ),
      ),
      body: Consumer<MusicPlayerViewmodel>(
        builder:
            (BuildContext context, MusicPlayerViewmodel value, Widget? child) {
          return Column(
            children: [
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 48),
                  child: Column(
                    children: [
                      Container(
                        width: 320,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: AvatarCircleContainer(
                          imageUrl: value.playlist[value.currentIndex!].image!,
                          radius: 160,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        value.playlist[value.currentIndex!]
                                            .title,
                                        style: AppTypography.titleBold.copyWith(
                                            color: AppColors.neutralWhite),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text(
                                      value.playlist[value.currentIndex!].artist
                                          .join(", "),
                                      style: AppTypography.titleRegular
                                          .copyWith(
                                              color: AppColors.neutralWhite),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(CupertinoIcons.heart_fill),
                                color: AppColors.neutralWhite,
                              )
                            ],
                          ))
                    ],
                  )),
              Container(
                height: 240,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Slider(
                          activeColor: AppColors.primary,
                          inactiveColor: AppColors.neutralWhite,
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: displayValue ??
                              value.currentDuration.inSeconds.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              displayValue = newValue;
                            });
                          },
                          onChangeEnd: (double finalValue) {
                            setState(() {
                              displayValue = null;
                            });
                            value.seek(Duration(seconds: finalValue.toInt()));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatTime(value.currentDuration),
                                style: AppTypography.captionRegular.copyWith(
                                  color: AppColors.neutralWhite,
                                ),
                              ),
                              Text(
                                formatTime(value.totalDuration),
                                style: AppTypography.captionRegular.copyWith(
                                  color: AppColors.neutralWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.repeat,
                            color: AppColors.neutralWhite,
                            size: 28,
                          ),
                        ),
                        IconButton(
                          onPressed: value.playPreviousSong,
                          icon: const Icon(
                            CupertinoIcons.backward_fill,
                            color: AppColors.neutralWhite,
                            size: 28,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            value.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: AppColors.primary,
                            size: 60,
                          ),
                          onPressed: value.pauseOrResume,
                        ),
                        IconButton(
                          onPressed: value.playNextSong,
                          icon: const Icon(
                            CupertinoIcons.forward_fill,
                            color: AppColors.neutralWhite,
                            size: 28,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.shuffle,
                            color: AppColors.neutralWhite,
                            size: 28,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
