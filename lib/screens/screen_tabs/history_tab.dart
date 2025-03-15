import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/viewmodel/auth_viewmodel.dart';
import 'package:sound_mp3/viewmodel/songs_viewmodel.dart';
import 'package:sound_mp3/screens/widgets/containers/history_list_container.dart';
import 'package:sound_mp3/screens/widgets/other/empty_display.dart';
import 'package:sound_mp3/screens/widgets/other/loading_display.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  int todayCount = 5;
  int yesterdayCount = 5;
  int threeDayAgoCount = 5;

  @override
  void initState() {
    Future.microtask(() {
      final userCredential =
          Provider.of<AuthViewmodel>(context, listen: false).currentUser;
      Provider.of<SongsViewmodel>(context, listen: false)
          .getHistorySongs(userCredential!.uid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          shadowColor: AppColors.neutralWhite.withOpacity(0.8),
          title: Text(
            "History",
            style:
                AppTypography.titleBold.copyWith(color: AppColors.neutralWhite),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
          child: Consumer<SongsViewmodel>(
            builder: (context, songViewmodel, widget) {
              // neu status dang la loading
              if (songViewmodel.todaySongs.status == ApiResponse.loading() ||
                  songViewmodel.yesterdaySongs.status ==
                      ApiResponse.loading() ||
                  songViewmodel.pastSongs.status == ApiResponse.loading()) {
                return const LoadingDisplay();
              }

              //neu du lieu chua duoc tai (uid chua duoc lay xong)
              if (songViewmodel.todaySongs.data == null ||
                  songViewmodel.yesterdaySongs.data == null ||
                  songViewmodel.pastSongs.data == null) {
                return const LoadingDisplay();
              }

              // tao sanh sach bai hat
              List<Songs> todaySongs = songViewmodel.todaySongs.data!;
              List<Songs> yesterdaySongs = songViewmodel.yesterdaySongs.data!;
              List<Songs> pastSongs = songViewmodel.pastSongs.data!;

              // chua co lich su nghe nhac
              if (todaySongs.isEmpty &&
                  yesterdaySongs.isEmpty &&
                  pastSongs.isEmpty) {
                return const EmptyDisplay(
                  message: 'You have no listening history.',
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // lich su bai hat nghe hom nay
                  todaySongs.isNotEmpty
                      ? HistoryListContainer(
                          title: 'Today',
                          items: todaySongs,
                          itemCount: todayCount,
                          seeMore: () {
                            setState(() {
                              todayCount = _seeMore(todayCount, todaySongs);
                            });
                          },
                        )
                      : const SizedBox.shrink(),

                  // lich su bai hat nghe hom qua
                  yesterdaySongs.isNotEmpty
                      ? HistoryListContainer(
                          title: 'Yesterday',
                          items: yesterdaySongs,
                          itemCount: yesterdayCount,
                          seeMore: () {
                            setState(() {
                              yesterdayCount =
                                  _seeMore(yesterdayCount, yesterdaySongs);
                            });
                          },
                        )
                      : const SizedBox.shrink(),

                  // lich su bai hat 3 ngay truoc do
                  pastSongs.isNotEmpty
                      ? HistoryListContainer(
                          title: 'Older',
                          items: pastSongs,
                          itemCount: threeDayAgoCount,
                          seeMore: () {
                            setState(() {
                              threeDayAgoCount =
                                  _seeMore(threeDayAgoCount, pastSongs);
                            });
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ));
  }

  int _seeMore(int currentCount, List<Songs> songList) {
    return (currentCount + 5).clamp(0, songList.length);
  }
}
