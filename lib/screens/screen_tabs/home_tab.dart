import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/mvvm/albums_viewmodel.dart';
import 'package:sound_mp3/mvvm/artists_viewmodel.dart';
import 'package:sound_mp3/mvvm/auth_viewmodel.dart';
import 'package:sound_mp3/mvvm/music_player_viewmodel.dart';
import 'package:sound_mp3/mvvm/songs_viewmodel.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/screens/widgets/app_bars/sliver_app_bar_delegate.dart';
import 'package:sound_mp3/screens/widgets/containers/carousel_slider_container.dart';
import 'package:sound_mp3/screens/widgets/containers/song_vertical_square_container.dart';
import 'package:sound_mp3/screens/widgets/other/error_display.dart';
import 'package:sound_mp3/screens/widgets/other/loading_display.dart';
import 'package:sound_mp3/screens/widgets/tab_bar_views.dart/artists_tab_bar_view.dart';
import 'package:sound_mp3/screens/widgets/tab_bar_views.dart/albums_tab_bar_view.dart';
import 'package:sound_mp3/screens/widgets/tab_bars/music_category_tab_bar.dart';
import 'package:sound_mp3/services/firestore/songs_service.dart';
import 'package:sound_mp3/utils/status.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late MusicPlayerViewmodel musicPlayerViewmodel;
  late Map<Widget, Widget> _categoryMap;

  @override
  void initState() {
    Future.microtask(() {
      Provider.of<SongsViewmodel>(context, listen: false).getAllSongs();
      Provider.of<ArtistsViewmodel>(context, listen: false).getAllArtists();
      Provider.of<AlbumsViewmodel>(context, listen: false).getAllAlbums();
    });
    musicPlayerViewmodel =
        Provider.of<MusicPlayerViewmodel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("HomeTab rebuilt");
    double width = MediaQuery.of(context).size.width;
    List<int> list = [1, 2, 3, 4, 5];

    _categoryMap = {
      const MusicCategoryTabBar(
        title: "Artists",
      ): const ArtistsTabBarView(),
      const MusicCategoryTabBar(
        title: "Album",
      ): const AlbumsTabBarView(),
      const MusicCategoryTabBar(
        title: "Podcast",
      ): const ArtistsTabBarView(),
      const MusicCategoryTabBar(
        title: "Genre",
      ): const ArtistsTabBarView(),
    };
    return DefaultTabController(
      length: _categoryMap.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
          title: Text(
            "Sound MP3",
            style: AppTypography.titleBold.copyWith(color: AppColors.primary),
          ),
          actions: [
            IconButton(
              onPressed: () {
                SongsService service = SongsService();
                service.getSongHistoryWithDetails("WwwQw8091JbLj55vZTMR");
              },
              //_logout,
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              //banner
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  height: 152,
                  width: width,
                  child: CarouselSlider(
                    options:
                        CarouselOptions(viewportFraction: 1, autoPlay: true),
                    items: list
                        .map((item) => const CarouselSliderContainer())
                        .toList(),
                  ),
                ),
              ),
              // today hit text
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Text("Today's hits",
                      style: AppTypography.titleBold
                          .copyWith(color: AppColors.neutralWhite)),
                ),
              ),
              // today hit list
              SliverToBoxAdapter(
                child: Container(
                    height: 175,
                    padding: const EdgeInsets.only(top: 8, left: 32),
                    child: Consumer<SongsViewmodel>(
                      builder: (context, songViewmodel, child) {
                        switch (songViewmodel.songs.status) {
                          case Status.loading:
                            return const LoadingDisplay();
                          case Status.error:
                            return ErrorDisplay(
                              message: songViewmodel.songs.message.toString(),
                            );
                          case Status.completed:
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: songViewmodel.songs.data?.length,
                              itemBuilder: (context, index) {
                                return SongVerticalSquareContainer(
                                  song: songViewmodel.songs.data![index],
                                  onPress: () {
                                    musicPlayerViewmodel.playlist =
                                        songViewmodel.songs.data!;
                                    musicPlayerViewmodel.currentIndex = index;

                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.musicPlayerScreen,
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
                    )),
              ),
              // category
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 8, top: 16, left: 16),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      labelColor: AppColors.neutralWhite,
                      unselectedLabelColor: AppColors.neutralGray,
                      dividerColor: Colors.transparent,
                      indicator: MaterialIndicator(
                        color: AppColors.primary,
                        height: 8,
                        bottomRightRadius: 10,
                        bottomLeftRadius: 10,
                        horizontalPadding: 30,
                        tabPosition: TabPosition.bottom,
                      ),
                      tabs: _categoryMap.keys.toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _categoryMap.values.toList(),
          ),
        ),
      ),
    );
  }

  //logout in setting button
  Future<void> _logout() async {
    final authViewModel = Provider.of<AuthViewmodel>(context, listen: false);
    await authViewModel.logout();
    if (authViewModel.currentUser == null) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    }
  }
}
