import 'dart:math';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Help_Center/controllers/faq_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqGridPagesView extends GetView {
  final String Title;
  const FaqGridPagesView({Key? key, required this.Title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FaqController faqController = Get.put(FaqController());
    final String selectedTitle = Get.arguments['title'];
    final faqs = faqController.faqMap[selectedTitle] ?? [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        leadingWidth: double.tryParse('175'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: GestureDetector(
            onTap: () {
              Get.closeAllSnackbars();
              Get.back(closeOverlays: true);
              ();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    selectedTitle.capitalize ?? '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffDADADA),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQ',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Obx(() {
                if (faqController.isLoading.value) {
                  return  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryFirstGradiant,
                    ),
                  );
                }
                if (faqController.faqMap.isEmpty) {
                  return const Center(child: Text("No FAQs available."));
                }
                return ListView.builder(
                  itemCount: faqs.length,
                  itemBuilder: (context, index) {
                    final faq = faqs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      semanticContainer: false,
                      child: ExpansionTile(
                        iconColor: AppColors.primaryGradinatMixColor,
                        collapsedIconColor: AppColors.primaryGradinatMixColor,
                        shape: Border.all(color: Colors.transparent),
                        title: Text(
                          ' ${faq.question}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                ' ${faq.answer}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
