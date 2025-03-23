import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/screens/widgets/containers/song_horizontal_square_container.dart';
import 'package:sound_mp3/viewmodel/music_player_viewmodel.dart';
import 'package:sound_mp3/viewmodel/songs_viewmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late MusicPlayerViewmodel musicPlayerViewmodel;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    musicPlayerViewmodel =
        Provider.of<MusicPlayerViewmodel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SongsViewmodel>(context);
    return Scaffold(
      backgroundColor: AppColors.neutralBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // implement the search field
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // This button is used to close the search modal
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.neutralWhite,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: const TextStyle(
                            color: AppColors.neutralBlack,
                            decorationColor: AppColors.neutralBlack),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          filled: true,
                          fillColor: AppColors.neutralWhite,
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchController.clear;
                                searchProvider.searchSongs("");
                              }),
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onChanged: (query) =>
                            searchProvider.searchSongs(_searchController.text),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: searchProvider.searchResults.data == null
                    ? const SizedBox.shrink()
                    : searchProvider.searchResults.data!.isEmpty
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            itemCount:
                                searchProvider.searchResults.data!.length,
                            itemBuilder: (context, index) {
                              final song =
                                  searchProvider.searchResults.data![index];
                              return SongHorizontalSquareContainer(
                                  song: song,
                                  onPress: () {
                                    musicPlayerViewmodel.playlist =
                                        searchProvider.searchResults.data!;
                                    musicPlayerViewmodel.currentIndex = index;

                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.musicPlayerScreen,
                                    );
                                  });
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
