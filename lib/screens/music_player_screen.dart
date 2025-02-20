import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final PageController _pageController = PageController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.setUrl(
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
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
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildPlayingScreen(),
                _buildLyricsScreen(),
              ],
            ),
          ),
          Container(
            height: 240,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
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
                        max: 50,
                        value: 3,
                        onChanged: (value) {}),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "00:00",
                            style: AppTypography.captionRegular.copyWith(
                              color: AppColors.neutralWhite,
                            ),
                          ),
                          Text(
                            "00:00",
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
                      icon: Icon(
                        CupertinoIcons.repeat, //CupertinoIcons.repeat,
                        color: AppColors.neutralWhite,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.backward_fill,
                        color: AppColors.neutralWhite,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: Colors.green,
                        size: 60,
                      ),
                      onPressed: _togglePlayPause,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.forward_fill,
                        color: AppColors.neutralWhite,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
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
      ),
    );
  }

  Widget _buildPlayingScreen() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 32, right: 32, top: 48),
        child: Column(
          children: [
            Container(
              width: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  "https://i.pinimg.com/236x/5e/e0/82/5ee082781b8c41406a2a50a0f32d6aa6.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("lỷics",
                            style: AppTypography.titleBold
                                .copyWith(color: AppColors.neutralWhite),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(
                          "name singer",
                          style: AppTypography.titleRegular
                              .copyWith(color: AppColors.neutralWhite),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.heart_fill),
                      color: AppColors.neutralWhite,
                    )
                  ],
                ))
          ],
        ));
  }

  Widget _buildLyricsScreen() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images2.thanhnien.vn/zoom/700_438/528068263637045248/2024/1/26/e093e9cfc9027d6a142358d24d2ee350-65a11ac2af785880-17061562929701875684912-37-0-587-880-crop-1706239860681642023140.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.neutralGray.withOpacity(0.5),
            BlendMode.srcATop,
          ),
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Sisa Rasa",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Mahalini",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Text(
              "Masih jelas teringat...\nSeakan semua tak mungkin...\nKini hanya kenangan...\nTak tersisa lagi waktu...\n\nMengapa masih ada...\nDi saat kau pergi...\nMampukah ku bertahan... Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...Di saat kau pergi...\nMampukah ku bertahan...",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
