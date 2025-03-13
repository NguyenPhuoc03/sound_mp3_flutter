import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/playlist_horizontal_square_container.dart';

class HistoryListContainer extends StatelessWidget {
  final String title;
  final List<String> items;
  final int itemCount;
  final VoidCallback seeMore;
  const HistoryListContainer(
      {super.key,
      required this.title,
      required this.items,
      required this.itemCount,
      required this.seeMore});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            title,
            style:
                AppTypography.titleBold.copyWith(color: AppColors.neutralWhite),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return const PlaylistHorizontalSquareContainer();
            }),
        if (itemCount < items.length)
          TextButton(
            onPressed: seeMore,
            child: Text("See all",
                style: AppTypography.bodySemiBold
                    .copyWith(color: AppColors.neutralWhite)),
          ),
      ],
    );
  }
}
