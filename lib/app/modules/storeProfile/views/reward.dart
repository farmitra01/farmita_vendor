// import 'package:farmitra/main.dart' as AppColors;
import 'dart:math' as math;

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/reward_controller.dart';
import 'package:farmitra/app/modules/storeProfile/views/refer&earn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RewardView extends GetView {
  RewardView({super.key});
  final RewardController rewardController = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: rewardController.scrollController,
        slivers: [
          Obx(
            () => SliverAppBar(
              centerTitle: true,
              expandedHeight: 300.0,
              pinned: true,
              title: Text(
                'Reward History',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color:
                      rewardController.isScrolled.value
                          ? AppColors.primaryGradinatMixColor
                          : Colors.white,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryFirstGradiant,
                            AppColors.primaryGradinatMixColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                    // Centered Image
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Lottie.asset('assets/json/refer_earn.json'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 75,
                                child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.primaryGradinatMixColor,
                                  radius: 70,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 55,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "900",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryGradinatMixColor,
                                    ),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Farmitra \n Points",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryGradinatMixColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70.0, right: 8),
                        child: Lottie.asset(
                          'assets/json/coins.json',
                          height: 200,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ReferNowButton(),
                        // Container(
                        //   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25),border: Border.all(width: 2,color: AppColors.main)),
                        // child: Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 8),
                        //   child: Text('Refer Now',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        // ),
                        // )
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      rewardController.isScrolled.value
                          ? AppColors.primaryGradinatMixColor
                          : Colors.white,
                ),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color:
                        rewardController.isScrolled.value
                            ? AppColors.primaryGradinatMixColor
                            : Colors.white,
                  ),
                  onPressed: () {
                    Get.to(
                      () => ReferEarnView(),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                ),
              ],
            ),
          ),
          // Balance Sections
          // SliverToBoxAdapter(
          //   child: Column(
          //     children: [
          //       SizedBox(height: 5),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 0.0),
          //         child
          //         : CustomTabBar(
          //           tabNames: ['Earned', 'Redeemed'],
          //           onTabSelected: (index) {
          //             rewardController.updateSelectedTab(index);
          //           },
          //           selectedIndex: rewardController.selectedIndex,
          //         ),
          //       ),
          //       SizedBox(height: 0),
          //     ],
          //   ),
          // ),
          // Transactions List
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate((
                BuildContext context,
                int index,
              ) {
                final transaction =
                    rewardController.filteredTransactions[index];
                return _buildTransactionCard(transaction);
              }, childCount: rewardController.filteredTransactions.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: AppColors.primaryGradinatMixColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        leading: Icon(
          transaction['points'] > 0 ? Icons.add : Icons.remove,
          color: transaction['points'] > 0 ? Colors.green : Colors.red,
        ),
        title: Text(
          transaction['points'] > 0 ? "You have earned" : "You have redeemed",
          style: TextStyle(fontSize: 15),
        ),
        subtitle: Text(transaction['date'], style: TextStyle(fontSize: 13)),
        trailing: Text(
          "${transaction['points'] > 0 ? '+' : ''}${transaction['points']} Points",
          style: TextStyle(
            fontSize: 13,
            color: transaction['points'] > 0 ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ReferNowButton extends StatefulWidget {
  @override
  _ReferNowButtonState createState() => _ReferNowButtonState();
}

class _ReferNowButtonState extends State<ReferNowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10), // Duration of the animation
    )..repeat(); // Repeat the animation endlessly
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Animated Border
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 158,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2, color: Colors.transparent),
                    gradient: SweepGradient(
                      startAngle: -20.0,
                      endAngle: 2 * math.pi, // Full circular gradient
                      colors: [
                        AppColors.yellow,
                        Colors.blue,
                        Colors.green,
                        Colors.yellow,
                        AppColors.primaryGradinatMixColor,
                      ],
                      stops:
                          [
                            _controller.value,
                            _controller.value + 0.25,
                            _controller.value + 0.5,
                            _controller.value + 0.75,
                            1.0,
                          ].map((stop) => stop % 1.0).toList(),
                    ),
                  ),
                );
              },
            ),
            // Inner Container
            Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: Text(
                'Refer Now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.primaryGradinatMixColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ReferNowButton extends StatefulWidget {
//   @override
//   _ReferNowButtonState createState() => _ReferNowButtonState();
// }

// class _ReferNowButtonState extends State<ReferNowButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   // final ReferEarnController controller = Get.put(ReferEarnController());
//   @override
//   void initState() {
//     super.initState();
//     // Initialize AnimationController
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 3), // Adjust the speed of the animation
//     )..repeat(); // Make the animation repeat indefinitely
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 0.0),
//         child: CustomPaint(
//           painter: BorderPainter(animation: _controller),
//           child: GestureDetector(
//             onTap: () {
//               controller.shareReferralWithImage();
//             },
//             child: Container(
//               width: 140,
//               height: 40,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Text(
//                 'Refer Now',
//                 style: GoogleFonts.montserrat(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                   color: AppColors.primaryGradinatMixColor,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class BorderPainter extends CustomPainter {
  final Animation<double> animation;

  BorderPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final borderRadius = BorderRadius.circular(25);
    final path = Path()..addRRect(borderRadius.toRRect(rect));

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth =
              4.0 // Border width
          ..shader = SweepGradient(
            startAngle: 0.0,
            endAngle: 2 * math.pi,
            colors: [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.purple,
            ],
            stops: [
              animation.value,
              (animation.value + 0.25) % 1.0,
              (animation.value + 0.5) % 1.0,
              (animation.value + 0.75) % 1.0,
              1.0,
            ],
          ).createShader(rect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
