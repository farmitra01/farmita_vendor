import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/storeProfile/views/profile_view.dart';
import 'package:flutter/material.dart';

class CustomProfileCard extends StatelessWidget {
  final Widget? additionalContent;

  CustomProfileCard({this.additionalContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Card(
                  elevation: 0,
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        additionalContent ?? SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 3,
                  left: 0,
                  right: 0,
                  child: HexagonalAvatar(),
                ),
                Positioned(
                  bottom: 3,
                  left: 0,
                  right: 0,
                  child: HexagonalAvatar2(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
