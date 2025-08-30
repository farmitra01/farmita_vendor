import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/registration/controllers/store_selected_module_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreSelectedModuleView extends GetView<StoreSelectedModuleController> {
  const StoreSelectedModuleView({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreSelectedModuleController storeSelectedModuleController = Get.put(
      StoreSelectedModuleController(),
    );
    // Avoid instantiating controller in build; assume it's injected via GetX dependency injection
    final previousSelectedValue = Get.arguments;
    debugPrint(
      'StoreSelectedModuleView => Controller: ${controller.hashCode}, PreviousSelectedValue: $previousSelectedValue',
    );

    // Extract categoryId and categoryName from arguments
    String? categoryId;
    String? categoryName;
    if (previousSelectedValue != null) {
      final parts = previousSelectedValue.split(',');
      for (var part in parts) {
        if (part.startsWith('id:')) {
          categoryId = part.split(':')[1];
        } else if (part.startsWith('name:')) {
          categoryName = part.split(':')[1];
        }
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        onHelpTap: () => Get.toNamed('/help-center'),
        onTranslateTap: () => Get.toNamed('/add'),
      ),
      body: Padding(
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
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Text(
                          categoryName ?? 'Unknown',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text(
                            'Edit     ',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGradinatMixColor,
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
                    decoration:  BoxDecoration(
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
                          decoration:  BoxDecoration(
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
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Select a module',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Module under which your business suits well.',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                debugPrint(
                  'Building Grid => isLoading: ${controller.isLoading.value}, '
                  'Items Count: ${controller.items3.length}',
                );

                return Stack(
                  children: [
                    if (controller.isLoading.value)
                       Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),

                    if (!controller.isLoading.value &&
                        controller.items3.isEmpty)
                      const Center(child: Text('No modules available.')),

                    if (!controller.isLoading.value &&
                        controller.items3.isNotEmpty)
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemCount: controller.items3.length,
                        itemBuilder: (context, index) {
                          final item = controller.items3[index];

                          return Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.selectItem(index);
                                debugPrint(
                                  'Selected Item: ${item.name}, Index: $index',
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.white,
                                      // AppColors.primaryGradinatMixColor,
                                      // .withOpacity(0.2),
                                      controller
                                          .colors[index %
                                              controller.colors.length]
                                          .withOpacity(0.1),
                                    ],
                                    stops: const [0.4, 1.0],
                                  ),
                                  border: Border.all(
                                    color:
                                        controller.selectedIndex.value == index
                                            ? AppColors.primaryGradinatMixColor
                                            : Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Radio<int>(
                                          value: index,
                                          groupValue:
                                              controller.selectedIndex.value,
                                          activeColor:
                                              AppColors.primaryGradinatMixColor,
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.selectItem(value);
                                              debugPrint(
                                                'Radio Selected: $value',
                                              );
                                            }
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            item.name ?? "",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  controller.colors[index %
                                                      controller.colors.length],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(height: 15),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.network(
                                        'https://api.farmitra.in/storage/${item.image}',
                                        height: 75,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Center(
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                  ),
                                                ),
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
                                          onTap: () {
                                            controller.selectedIndex.value =
                                                index;
                                            showInfoBottomSheet(
                                              items: controller.items3,
                                              selectedIndex:
                                                  controller.selectedIndex,
                                            );
                                          },
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
                        },
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: CustomGradientButton(
          text: 'Proceed',
          onPressed: () {
            if (controller.items3.value.isNotEmpty) {
              debugPrint(
                'Proceeding to /store_category with Title: ${controller.gridTitle.value}, Controller: ${controller.hashCode}',
              );
              Get.toNamed(
                '/store_category',
                arguments: controller.gridTitle.value,
              );
            } else {
              Get.snackbar(
                'Error',
                'Please select a module',
                snackPosition: SnackPosition.TOP,
                colorText: AppColors.white,
              );
            }
          },
        ),
      ),
    );
  }
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
                      (bounds) =>  LinearGradient(
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
                  child:  Icon(
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
                      child:  CircleAvatar(
                        child: Icon(Icons.arrow_back, color: AppColors.white),
                        backgroundColor: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  const Spacer(),
                  if (selectedIndex.value < items.length - 1)
                    GestureDetector(
                      onTap: () => selectedIndex.value++,
                      child:  CircleAvatar(
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
