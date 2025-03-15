import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/data/models/artists.dart';
import 'package:sound_mp3/viewmodel/artists_viewmodel.dart';
import 'package:sound_mp3/viewmodel/songs_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/screens/widgets/containers/playlist_horizontal_circle_container.dart';
import 'package:sound_mp3/screens/widgets/other/error_display.dart';
import 'package:sound_mp3/screens/widgets/other/loading_display.dart';
import 'package:sound_mp3/utils/app_strings.dart';
import 'package:sound_mp3/utils/status.dart';

class ArtistsTabBarView extends StatelessWidget {
  const ArtistsTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8, left: 32, right: 16),
        child: Consumer<ArtistsViewmodel>(
          builder: (context, artistsViewmodel, child) {
            switch (artistsViewmodel.artists.status) {
              case Status.loading:
                return const LoadingDisplay();
              case Status.error:
                return ErrorDisplay(
                  message: artistsViewmodel.artists.message.toString(),
                );
              case Status.completed:
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: artistsViewmodel.artists.data?.length,
                  itemBuilder: (context, index) {
                    return PlaylistHorizontalCircleContainer<Artists>(
                      data: artistsViewmodel.artists.data![index],
                      onPress: () async {
                        String artId =
                            artistsViewmodel.artists.data![index].id!;
                        await Provider.of<SongsViewmodel>(context,
                                listen: false)
                            .getSongsByArtistId(artId);

                        Navigator.pushNamed(
                          context,
                          AppRoutes.songListScreen,
                          arguments: {
                            AppStrings.key: AppStrings.artist,
                            AppStrings.value: artId
                          },
                        );
                      },
                    );
                  },
                );
              default:
                return const ErrorDisplay(
                  message: "No active",
                );
            }
          },
        ));
  }
}
