import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/screens/widgets/containers/song_horizontal_square_container.dart';
import 'package:sound_mp3/viewmodel/music_player_viewmodel.dart';

class HistoryListContainer extends StatefulWidget {
  final String title;
  final List<Songs> items;
  final int itemCount;
  final VoidCallback seeMore;
  const HistoryListContainer(
      {super.key,
      required this.title,
      required this.items,
      required this.itemCount,
      required this.seeMore});

  @override
  State<HistoryListContainer> createState() => _HistoryListContainerState();
}

class _HistoryListContainerState extends State<HistoryListContainer> {
  late MusicPlayerViewmodel musicPlayerViewmodel;
  @override
  void initState() {
    musicPlayerViewmodel =
        Provider.of<MusicPlayerViewmodel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            widget.title,
            style:
                AppTypography.titleBold.copyWith(color: AppColors.neutralWhite),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.itemCount.clamp(0, widget.items.length),
            itemBuilder: (context, index) {
              return SongHorizontalSquareContainer(
                song: widget.items[index],
                onPress: () {
                  musicPlayerViewmodel.playlist = widget.items;
                  musicPlayerViewmodel.currentIndex = index;

                  Navigator.pushNamed(
                    context,
                    AppRoutes.musicPlayerScreen,
                  );
                },
              );
            }),
        TextButton(
          onPressed: widget.seeMore,
          child: Text("See all",
              style: AppTypography.bodySemiBold
                  .copyWith(color: AppColors.neutralWhite)),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
