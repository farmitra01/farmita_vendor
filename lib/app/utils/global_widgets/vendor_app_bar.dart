import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showTitle; // Control whether to show the title

  const VendorAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showTitle = true, // Default to showing the title
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    );
    final double titleWidth =
        showTitle
            ? (TextPainter(
              text: TextSpan(text: title, style: titleStyle),
              maxLines: 1,
              textDirection: TextDirection.ltr,
            )..layout()).width
            : 0;

    return AppBar(
      // leadingWidth:
      //     showTitle
      //         ? titleWidth + 75
      //         : 50, // Adjust leading width based on title visibility
      backgroundColor: AppColors.appBarColor,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: AppColors.white),
      leadingWidth: 35,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.white),
        ),
        child: Text(
          title,
          style: GoogleFonts.montserrat(fontSize: 13, color: AppColors.white),
        ),
      ),
      centerTitle: false,
      actions: actions,
    );
  }

  void closeSnackbarSafely() {
    try {
      // Check if snackbar is open before attempting to close
      if (Get.isSnackbarOpen) {
        Future.delayed(Duration.zero, () {
          try {
            // This may still throw if GetX's snackbar controller was never initialized
            Get.closeCurrentSnackbar();
          } catch (e) {
            debugPrint('❌ Error closing snackbar: $e');
          }
        });
      }
    } catch (e) {
      debugPrint('❌ Outer error in closeSnackbarSafely: $e');
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// class SnackbarUtil {
//   static void safeClose() {
//     try {
//       if (Get.isSnackbarOpen) {
//         Future.delayed(Duration.zero, () {
//           try {
//             Get.closeCurrentSnackbar();
//           } catch (e) {
//             debugPrint('Snackbar close failed: $e');
//           }
//         });
//       }
//     } catch (e) {
//       debugPrint('Snackbar guard outer failed: $e');
//     }
//   }
// }
