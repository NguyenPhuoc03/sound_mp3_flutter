import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/data/models/albums.dart';
import 'package:sound_mp3/viewmodel/albums_viewmodel.dart';
import 'package:sound_mp3/viewmodel/songs_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/screens/widgets/containers/playlist_horizontal_circle_container.dart';
import 'package:sound_mp3/screens/widgets/other/error_display.dart';
import 'package:sound_mp3/screens/widgets/other/loading_display.dart';
import 'package:sound_mp3/utils/app_strings.dart';
import 'package:sound_mp3/utils/status.dart';

class AlbumsTabBarView extends StatelessWidget {
  const AlbumsTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8, left: 32, right: 16),
        child: Consumer<AlbumsViewmodel>(
          builder: (context, albumsViewmodel, child) {
            switch (albumsViewmodel.albums.status) {
              case Status.loading:
                return const LoadingDisplay();
              case Status.error:
                return ErrorDisplay(
                  message: albumsViewmodel.albums.message.toString(),
                );
              case Status.completed:
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: albumsViewmodel.albums.data?.length,
                  itemBuilder: (context, index) {
                    return PlaylistHorizontalCircleContainer<Albums>(
                      data: albumsViewmodel.albums.data![index],
                      onPress: () async {
                        String albumId =
                            albumsViewmodel.albums.data![index].id!;
                        await Provider.of<SongsViewmodel>(context,
                                listen: false)
                            .getSongsByAlbumId(albumId);

                        Navigator.pushNamed(
                          context,
                          AppRoutes.songListScreen,
                          arguments: {
                            AppStrings.key: AppStrings.album,
                            AppStrings.value: albumId
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
