import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/screens/screen_tabs/history_tab.dart';
import 'package:sound_mp3/screens/screen_tabs/home_tab.dart';
import 'package:sound_mp3/screens/screen_tabs/playlist_tab.dart';
import 'package:sound_mp3/screens/screen_tabs/profile_tab.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _tabs = [
    const HomeTab(),
    const PlaylistTab(),
    const HistoryTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.neutralBlack,
        systemNavigationBarColor: AppColors.neutralGray,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _tabs,
          ),
        ),
        bottomNavigationBar: WaterDropNavBar(
          bottomPadding: 4,
          backgroundColor: AppColors.neutralGray,
          waterDropColor: AppColors.primary,
          barItems: [
            BarItem(
              filledIcon: CupertinoIcons.music_house_fill,
              outlinedIcon: CupertinoIcons.music_house,
            ),
            BarItem(
              filledIcon: CupertinoIcons.music_albums_fill,
              outlinedIcon: CupertinoIcons.music_albums,
            ),
            BarItem(
              filledIcon: Icons.access_time_filled,
              outlinedIcon: Icons.access_time,
            ),
            BarItem(
              filledIcon: CupertinoIcons.person_circle_fill,
              outlinedIcon: CupertinoIcons.profile_circled,
            ),
          ],
          selectedIndex: _selectedIndex,
          onItemSelected: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(_selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
