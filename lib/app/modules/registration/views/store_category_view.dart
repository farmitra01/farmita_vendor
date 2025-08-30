import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/ApiModels/getModuleSubCategory.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_selected_module_controller.dart';
import 'package:farmitra/app/modules/registration/views/retailer_store_details_form.dart';
import 'package:farmitra/app/modules/registration/views/RetailerStoreDetailsFrom1.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreCategoryView extends GetView<StoreCategoryController> {
  StoreCategoryView({super.key});

  @override
  final StoreCategoryController controller = Get.put(StoreCategoryController());
  final StoreSelectedModuleController storeSelectedModuleController = Get.put(
    StoreSelectedModuleController(),
  );

  @override
  Widget build(BuildContext context) {
    final previousPageGridTitle =
        Get.arguments?.toString() ?? 'id:0,name:Default Category';
    String? argumentedBusinessModuleId;
    String? categoryName;
    if (previousPageGridTitle.isNotEmpty) {
      final parts = previousPageGridTitle.split(',');
      for (var part in parts) {
        if (part.startsWith('id:')) {
          argumentedBusinessModuleId = part.split(':')[1];
        } else if (part.startsWith('name:')) {
          categoryName = part.split(':')[1];
        }
      }
    }
    // String? argumentedModuleCategoryId;
    // String? argumentCategoryName;

    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        onHelpTap: () => Get.toNamed('/help-center'),
        onTranslateTap: () => Get.toNamed('/add'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              categoryName ?? 'Unknown',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Text(
                              'Edit     ',
                              style: GoogleFonts.montserrat(
                                color: AppColors.primaryGradinatMixColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 45,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryFirstGradiant,
                            AppColors.primarySecondGradiant,
                          ],
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.primaryFirstGradiant,
                                  AppColors.primarySecondGradiant,
                                ],
                              ),
                            ),
                            child: const CircleAvatar(
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  size: 15,
                                  color: AppColors.white,
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Select  ${categoryName}  Categories -',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'A category that describes your business well.',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  );
                } else if (controller.gridContent.isEmpty) {
                  return const Center(
                    child: Text('No subcategories available'),
                  );
                } else {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: controller.gridContent.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final item = controller.gridContent[index];
                        final isSelected =
                            controller.selectedItems.contains(index) ||
                            controller.selectedIndex.value == index;

                        return GestureDetector(
                          onTap: () {
                            controller.selectItem(index);
                            controller.toggleSelection(index);
                          },
                          child: Container(
                            // margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? AppColors.primaryGradinatMixColor
                                        : AppColors.border,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://api.farmitra.in/storage/${item.image}',
                                    height: 35,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.bottomLeft,
                                    color:
                                        isSelected
                                            ? AppColors.textPrimary
                                            : AppColors.textSecondary,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                  // if (item.imagePath != null &&
                                  //     item.imagePath!.isNotEmpty)
                                  //   SvgPicture.asset(
                                  //     item.imagePath!,
                                  //     height: 28,
                                  //     color: isSelected
                                  // ? AppColors.textPrimary
                                  // : AppColors.textSecondary,

                                  //   )
                                  // else
                                  //   Icon(
                                  //     Icons.category,
                                  //     color:
                                  //         isSelected
                                  //             ? AppColors.textPrimary
                                  //             : AppColors.textSecondary,
                                  //   ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item.name ?? 'Unknown',
                                    maxLines: 3,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isSelected
                                              ? AppColors.textPrimary
                                              : AppColors.textSecondary,
                                    ),
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 5,
                                        bottom: 5,
                                      ),
                                      child: GestureDetector(
                                        onTap:
                                            () => showInfoBottomSheet(
                                              items: controller.gridContent,
                                              selectedIndex:
                                                  controller.selectedIndex,
                                            ),
                                        child: const Icon(
                                          Icons.error_outline_rounded,
                                          size: 20,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                }
              }),
              SizedBox(height: 10),
              // GestureDetector(
              //   onTap:
              //       () => showBottomSheet(
              //         context,
              //         categoryId: argumentedBusinessModuleId,
              //       ),
              //   child: DottedBorder(
              //     borderType: BorderType.RRect,
              //     color: AppColors.border,
              //     radius: const Radius.circular(10),
              //     child: ClipRRect(
              //       borderRadius: const BorderRadius.all(Radius.circular(10)),
              //       child: Container(
              //         padding: const EdgeInsets.all(5),
              //         height: 120,
              //         width: 95,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const Icon(
              //               Icons.add_circle_sharp,
              //               color: AppColors.secondary,
              //             ),
              //             const SizedBox(height: 10),
              //             Text(
              //               'Custom',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w500,
              //                 color: AppColors.secondary,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomGradientButton(
              text: 'Proceed',
              onPressed: () {
                if (controller.selectedIndex.value >= 0 &&
                    controller.gridContent.isNotEmpty) {
                  final selectedItem =
                      controller.gridContent[controller.selectedIndex.value];
                  // Get.toNamed('/retailer_store_details_form');
                  // Get.to(SampleView());
                  // Get.to(() => RentalKyc());
                  // Get.toNamed('/store_details_form');

                  if (categoryName == 'Expert') {
                    // Get.to(RetailerStoreDetailsFrom());
                    Get.toNamed('/store_details_form', arguments: categoryName);

                    print('argument of Nature of Business ${categoryName}');
                  } else {
                    Get.to(
                      () => RetailerStoreDetailsFrom1(),
                      arguments: {
                        'moduleCategoryId': controller.moduleCategoryId,
                        'argumentedBusinessModuleId':
                            controller.businessModuleId,
                      },
                    );

                    // print('argument of Nature of Business ${categoryName}');
                  }
                } else {
                  Get.snackbar('Error', 'Please select a category');
                }
              },
            ),
            const SizedBox(height: 10),
            // Text(
            //   "You Can’t Skip this step",
            //   style: GoogleFonts.montserrat(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //     color: AppColors.textSecondary,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

void showBottomSheet(
  BuildContext context, {
  String? categoryId,
  String? businessModuleId,
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StoreCategoryController controller = Get.find();

  Get.bottomSheet(
    Form(
      key: formKey,
      child: Container(
        height: 250,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                ShaderMask(
                  shaderCallback:
                      (bounds) => LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primaryFirstGradiant,
                          AppColors.primarySecondGradiant,
                        ],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    'Add custom category:',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.cancel, color: Color(0xff636363)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Give a name to your custom category',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff636363),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.customeCategory,
              decoration: InputDecoration(
                hintText: "Custom Category",
                hintStyle: const TextStyle(
                  color: Color(0xff636363),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color(0xffDADADA)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Category Name';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryFirstGradiant,
                    AppColors.primarySecondGradiant,
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final now = DateTime.now().toIso8601String();
                    final item = ModuleSubCategory(
                      id: -(controller.gridContent.length + 1),
                      name: controller.customeCategory.text,
                      business_module_id:
                          int.tryParse(businessModuleId ?? '0') ?? 0,
                      moduleCategoryId: int.tryParse(categoryId ?? '0') ?? 0,
                      description: 'Custom category',
                      status: 'active',
                      createdAt: now,
                      updatedAt: now,
                      image: 'assets/svgs/default_category.svg',
                    );
                    controller.addGridItem(item);
                    controller.selectItem(controller.gridContent.length - 1);
                    Get.back();
                    controller.customeCategory.clear();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.white, size: 10),
                    Text(
                      'Add',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.white,
  );
}

void showInfoBottomSheet({
  required List<dynamic> items,
  required RxInt selectedIndex,
}) {
  Get.bottomSheet(
    Obx(() {
      final item = items[selectedIndex.value];

      return Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * .25,
          minHeight: 150,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name and close
            Row(
              children: [
                Image.network(
                  'https://api.farmitra.in/storage/${item.image ?? ''}',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 50),
                ),
                const SizedBox(width: 5),

                ShaderMask(
                  shaderCallback:
                      (bounds) => LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primaryFirstGradiant,
                          AppColors.primarySecondGradiant,
                        ],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    item.name ?? '',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.cancel_sharp,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  item.description ?? 'No description available',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
            ),

            // Arrows
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  if (selectedIndex.value > 0)
                    GestureDetector(
                      onTap: () => selectedIndex.value--,
                      child: CircleAvatar(
                        child: Icon(Icons.arrow_back, color: AppColors.white),
                        backgroundColor: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  const Spacer(),
                  if (selectedIndex.value < items.length - 1)
                    GestureDetector(
                      onTap: () => selectedIndex.value++,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                        ),
                        backgroundColor: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    }),
    isScrollControlled: true,
  );
}
