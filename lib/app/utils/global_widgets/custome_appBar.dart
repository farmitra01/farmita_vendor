import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onHelpTap;
  final VoidCallback onTranslateTap;
  final String language;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    this.title = " ",
    required this.onHelpTap,
    required this.onTranslateTap,
    required this.automaticallyImplyLeading,
    this.language = 'Eng',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      leadingWidth: 50.0,
      automaticallyImplyLeading: false,
      leading:
          automaticallyImplyLeading
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: InkWell(
                  onTap: () {
                    // ✅ Safe back navigation with snackbar close
                    if (Get.isSnackbarOpen) {
                      Get.closeCurrentSnackbar();
                    }
                    if (Get.key.currentState?.canPop() ?? false) {
                      Get.closeAllSnackbars();
                      Get.back(closeOverlays: true);
                      ();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              )
              : null,
      titleSpacing: 10,
      title: SizedBox(
        height: 75,
        width: 90,
        child: SvgPicture.asset('assets/svgs/AppbarLogoFarmitra.svg'),
      ),
      actions: [
        GestureDetector(
          onTap: onTranslateTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.translate, color: AppColors.white, size: 20),
                const SizedBox(width: 5),
                Text(language, style: const TextStyle(color: AppColors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onHelpTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Text(
                '?',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
