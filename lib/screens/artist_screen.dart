import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';
// chua co du lieu
class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.neutralBlack,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 230,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.neutralGray.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.neutralWhite),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/banner_image.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        "Tulus",
                        style: AppTypography.titleBold
                            .copyWith(color: AppColors.neutralWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Phần Follow Button cố định khi cuộn
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyHeaderDelegate(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 32, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Albums",
                        style: AppTypography.titleBold
                            .copyWith(color: AppColors.neutralWhite)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 175,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) => AlbumCard(
                          image: 'assets/banner_image.jpg',
                          title: 'Manusia',
                          year: '2022',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text("Songs",
                    style: AppTypography.titleBold
                        .copyWith(color: AppColors.neutralWhite)),
              ),
            ),
          ],
          body: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) => ListTile(
              leading: Image.asset('assets/banner_image.jpg'),
              title: Text("Hati-Hati di Jalan",
                  style: TextStyle(color: Colors.white)),
              subtitle: Text("Tulus", style: TextStyle(color: Colors.white70)),
              trailing: Icon(Icons.more_vert, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// Delegate để giữ Follow Button cố định
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 70;
  @override
  double get maxExtent => 70;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      color: AppColors.neutralBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "12,7K",
                style: AppTypography.titleSemiBold
                    .copyWith(color: AppColors.neutralWhite),
              ),
              Text(
                "Followers",
                style: AppTypography.captionRegular
                    .copyWith(color: AppColors.neutralWhite),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.neutralWhite),
              ),
            ),
            child: Text(
              "Follow",
              style: AppTypography.bodySemiBold
                  .copyWith(color: AppColors.neutralWhite),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(StickyHeaderDelegate oldDelegate) => false;
}

// Widget AlbumCard
class AlbumCard extends StatelessWidget {
  final String image;
  final String title;
  final String year;

  const AlbumCard(
      {super.key,
      required this.image,
      required this.title,
      required this.year});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(color: Colors.white)),
          Text(year, style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
