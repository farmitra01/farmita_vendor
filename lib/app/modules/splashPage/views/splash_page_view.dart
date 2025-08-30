import 'package:farmitra/app/modules/splashPage/controllers/splash_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: splashController.slideAnimation,
          child: SvgPicture.asset(
            'assets/svgs/farmitra.svg',
            height: 100,
            width: 250,
          ),
        ),
      ),
    );
  }
}
