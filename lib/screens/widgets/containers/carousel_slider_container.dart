import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';
import 'package:sound_mp3/configs/typography.dart';

class CarouselSliderContainer extends StatelessWidget {
  const CarouselSliderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.secondary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Popular",
                style: AppTypography.bodySemiBold,
              ),
              Text(
                "Sisa Rasa",
                style: AppTypography.titleBold,
              ),
              Text(
                "Mahalini",
                style: AppTypography.headlineSemiBold,
              )
            ],
          ),
          Container(
            width: 144,
            height: 152,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage("assets/banner_image.jpg"))),
          ),
        ],
      ),
    );
  }
}
