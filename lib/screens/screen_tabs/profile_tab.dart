import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
import 'package:sound_mp3/screens/widgets/containers/avatar_circle_container.dart';
import 'package:sound_mp3/screens/widgets/containers/icon_button_container.dart';

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
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              height: 1 * size.height / 3,
              width: size.width,
              decoration: const BoxDecoration(
                  color: AppColors.neutralGray,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: AvatarCircleContainer(
                      radius: 48,
                      imageUrl:
                          'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Phuoc",
                          style: AppTypography.titleSemiBold.copyWith(
                            color: AppColors.neutralWhite,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "nguyenhuynhphuoc.2003@gmail.com",
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
                            "Followers",
                            style: AppTypography.captionRegular.copyWith(
                              color: AppColors.neutralWhite,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "145",
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
                            "555",
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
            Expanded(
                child: ListView(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Mostly played",
                    style: AppTypography.titleBold
                        .copyWith(color: AppColors.neutralWhite),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return Center();
                      // const SongHorizontalSquareContainer(
                      //    song: ,
                      // );
                    }),
              ],
            )),
          ],
        ));
  }
}
