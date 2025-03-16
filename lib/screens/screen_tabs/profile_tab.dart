import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/routes/app_routes.dart';
import 'package:sound_mp3/screens/widgets/containers/avatar_circle_container.dart';
import 'package:sound_mp3/screens/widgets/containers/icon_button_container.dart';
import 'package:sound_mp3/screens/widgets/list_title/profile_list_title.dart';
import 'package:sound_mp3/screens/widgets/other/loading_display.dart';
import 'package:sound_mp3/viewmodel/auth_viewmodel.dart';
import 'package:sound_mp3/viewmodel/users_viewmodel.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.neutralGray,
      statusBarIconBrightness: Brightness.light,
    ));

    Future.microtask(() {
      final userCredential =
          Provider.of<AuthViewmodel>(context, listen: false).currentUser;
      Provider.of<UsersViewmodel>(context, listen: false)
          .getUser(userCredential!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.neutralBlack,
      appBar: AppBar(
        backgroundColor: AppColors.neutralGray,
        title: Text(
          "Profile",
          style:
              AppTypography.titleBold.copyWith(color: AppColors.neutralWhite),
        ),
      ),
      body: Consumer<UsersViewmodel>(
        builder: (context, usersViewmodel, widget) {
          // neu status dang la loading
          if (usersViewmodel.user.status == ApiResponse.loading()) {
            return const LoadingDisplay();
          }
          //neu du lieu chua duoc tai (uid chua duoc lay xong)
          if (usersViewmodel.user.data == null) {
            return const LoadingDisplay();
          }
          return Column(
            children: [
              // profile
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                height: size.height / 3,
                width: size.width,
                decoration: const BoxDecoration(
                    color: AppColors.neutralGray,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: AvatarCircleContainer(
                        radius: 48,
                        imageUrl: usersViewmodel.user.data!.avatar!,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            usersViewmodel.user.data!.name,
                            style: AppTypography.titleSemiBold.copyWith(
                              color: AppColors.neutralWhite,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            usersViewmodel.user.data!.email,
                            style: AppTypography.bodyRegular.copyWith(
                              color: AppColors.neutralWhite,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Favorites",
                              style: AppTypography.captionRegular.copyWith(
                                color: AppColors.neutralWhite,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              usersViewmodel.user.data!.likedSongs!.length
                                  .toString(),
                              style: AppTypography.titleSemiBold.copyWith(
                                color: AppColors.neutralWhite,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Following",
                              style: AppTypography.captionRegular.copyWith(
                                color: AppColors.neutralWhite,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              usersViewmodel.user.data!.likedArtists!.length
                                  .toString(),
                              style: AppTypography.titleSemiBold.copyWith(
                                color: AppColors.neutralWhite,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // find friend and share profile
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, left: 32, right: 32, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButtonContainer(
                      icon: CupertinoIcons.person_badge_plus_fill,
                      title: 'Find friend',
                      onPress: () {},
                    ),
                    IconButtonContainer(
                      icon: CupertinoIcons.share,
                      title: 'Share',
                      onPress: () {},
                    )
                  ],
                ),
              ),
              Container(
                height: 0.2,
                decoration: BoxDecoration(
                  color: AppColors.neutralWhite,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutralWhite.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: double.infinity,
              ),
              // button
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                  children: [
                    ProfileListTitle(
                        iconLeading: Icons.person,
                        title: 'Edit Profile',
                        onPress: () {}),
                    ProfileListTitle(
                        iconLeading: Icons.star,
                        title: 'Following',
                        onPress: () {}),
                    ProfileListTitle(
                        iconLeading: Icons.favorite,
                        title: 'Favorite Songs',
                        onPress: () {}),
                    ProfileListTitle(
                        iconLeading: Icons.logout,
                        title: 'Log Out',
                        onPress: _logout),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  //logout
  Future<void> _logout() async {
    final authViewModel = Provider.of<AuthViewmodel>(context, listen: false);
    await authViewModel.logout();
    if (authViewModel.currentUser == null) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    }
  }
}
