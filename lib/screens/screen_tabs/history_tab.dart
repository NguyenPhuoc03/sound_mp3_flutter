import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/history_list_container.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  int todayCount = 3;
  int yesterdayCount = 3;

  final List<String> todayItems =
      List.generate(10, (index) => "Today Item $index");
  final List<String> yesterdayItems =
      List.generate(8, (index) => "Yesterday Item $index");
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HistoryListContainer(
                title: 'Today',
                items: todayItems,
                itemCount: todayCount,
                seeMore: () {
                  setState(() {
                    todayCount = _seeMore(todayCount, todayItems);
                  });
                }),
            const SizedBox(height: 32),
            HistoryListContainer(
              title: 'Yesterday',
              items: yesterdayItems,
              itemCount: yesterdayCount,
              seeMore: () {
                setState(() {
                  yesterdayCount = _seeMore(yesterdayCount, yesterdayItems);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  int _seeMore(int currentCount, List<String> songList) {
    return (currentCount + 5).clamp(0, songList.length);
  }
}
