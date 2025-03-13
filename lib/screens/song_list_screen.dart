import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/mvvm/music_player_viewmodel.dart';
import 'package:sound_mp3/mvvm/songs_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/screens/widgets/containers/song_horizontal_square_container.dart';
import 'package:sound_mp3/screens/widgets/other/loading_display.dart';
import 'package:sound_mp3/screens/widgets/other/mini_player_widget.dart';
import 'package:sound_mp3/utils/filter_types.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({
    super.key,
  });

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  late MusicPlayerViewmodel musicPlayerViewmodel;
  late String artistId;
  late String albumId;
  String? type;
  String? value;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      type = args[FilterTypes.key];
      value = args[FilterTypes.value];
    }

    //! xu li neu artist_tab_bar_view chua goi duoc provider
    // Future.microtask(() {
    //   final songViewModel = Provider.of<SongsViewmodel>(context, listen: false);

    //   if (type == FilterTypes.artist) {
    //     songViewModel.getSongsByArtistId(value!);
    //   } else if (type == FilterTypes.album) {
    //     songViewModel.getSongsByAlbumId(value!);
    //   } else {}
    // });
  }

  @override
  void initState() {
    musicPlayerViewmodel =
        Provider.of<MusicPlayerViewmodel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.neutralBlack,
        appBar: AppBar(
          elevation: 5,
          shadowColor: AppColors.neutralWhite.withOpacity(0.8),
          title: Text(
            "Songs",
            style:
                AppTypography.titleBold.copyWith(color: AppColors.neutralWhite),
          ),
        ),
        body: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
                child: Consumer<SongsViewmodel>(
                  builder: (context, songViewmodel, child) {
                    List<Songs> songs = [];

                    if (type == FilterTypes.artist &&
                        songViewmodel.songsByArtistId.data != null) {
                      songs = songViewmodel.songsByArtistId.data!;
                    } else if (type == FilterTypes.album &&
                        songViewmodel.songsByAlbumId.data != null) {
                      songs = songViewmodel.songsByAlbumId.data!;
                    } else {}

                    return songs.isEmpty
                        ? const LoadingDisplay()
                        : ListView.builder(
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: songs.length,
                                itemBuilder: (context, index) {
                                  return SongHorizontalSquareContainer(
                                    song: songs[index],
                                    onPress: () {
                                      musicPlayerViewmodel.playlist = songs;
                                      musicPlayerViewmodel.currentIndex = index;

                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.musicPlayerScreen,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                  },
                )),
            MiniPlayerWidget(controller: MiniplayerController())
          ],
        ));
  }
}
