import 'dart:io';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_template_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class StoreTemplateView extends StatelessWidget {
  const StoreTemplateView({super.key});

  @override
  Widget build(BuildContext context) {
    final storeTemplateController = Get.put(StoreTemplateController());
    Get.put(StoreCategoryController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Store Profile & Cover',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: const [_CloseButton(), SizedBox(width: 10)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Obx(
          () =>
              storeTemplateController.isLoading.value
                  ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(thickness: 1, color: AppColors.border),
                      ),
                      const SizedBox(height: 20),
                      _ProfileAndBannerSection(
                        controller: storeTemplateController,
                      ),
                      const SizedBox(height: 20),
                      const _DividerWithOr(),
                      const SizedBox(height: 20),
                      _EditNameButton(onTap: () => _showNameDialog(context)),
                      const SizedBox(height: 20),
                      _TemplateSection(
                        title: 'Profile Templates:',
                        isEmpty: storeTemplateController.logos.isEmpty,
                        child: _LogoTemplates(
                          controller: storeTemplateController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _TemplateSection(
                        title: 'Banner Templates:',
                        isEmpty: storeTemplateController.banners.isEmpty,
                        child: _BannerTemplates(
                          controller: storeTemplateController,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: CustomGradientButton(
          text: 'Save',
          onPressed: () {
            print('StoreTemplateView: Save button pressed');
            if ((storeTemplateController.logoImage.value != null ||
                    (storeTemplateController.logos.isNotEmpty &&
                        storeTemplateController.selectedLogoIndex.value <
                            storeTemplateController.logos.length)) &&
                (storeTemplateController.bannerImage.value != null ||
                    (storeTemplateController.banners.isNotEmpty &&
                        storeTemplateController.selectedBannerIndex.value <
                            storeTemplateController.banners.length))) {
              final arguments = {
                'logoImage': storeTemplateController.logoImage.value?.path,
                'bannerImage': storeTemplateController.bannerImage.value?.path,
                'logoTemplate':
                    storeTemplateController.logos.isNotEmpty &&
                            storeTemplateController.selectedLogoIndex.value <
                                storeTemplateController.logos.length
                        ? storeTemplateController.logos[storeTemplateController
                            .selectedLogoIndex
                            .value]
                        : null,
                'bannerTemplate':
                    storeTemplateController.banners.isNotEmpty &&
                            storeTemplateController.selectedBannerIndex.value <
                                storeTemplateController.banners.length
                        ? storeTemplateController
                            .banners[storeTemplateController
                            .selectedBannerIndex
                            .value]
                        : null,
                'firstName': storeTemplateController.firstName.value,
                'lastName': storeTemplateController.lastName.value,
                'category':
                    Get.find<StoreCategoryController>().previousPageGridTitle,
              };
              print(
                'StoreTemplateView: Navigating to /store_details_form with arguments: $arguments',
              );
              // Get.toNamed('/store_details_form', arguments: arguments);
              Get.closeAllSnackbars();
              Get.back(closeOverlays: true);
              (result: arguments);
            } else {
              print(
                'StoreTemplateView: Invalid logo or banner selection for Save',
              );
              Get.snackbar(
                'Error',
                'Please select or upload both a logo and a banner',
                backgroundColor: AppColors.error,
                colorText: AppColors.white,
              );
            }
          },
        ),
      ),
    );
  }

  void _showNameDialog(BuildContext context) {
    final controller = Get.find<StoreTemplateController>();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Text(
                  'Edit Profile & Banner Name',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
                const Spacer(),
                const _CloseDialogButton(),
              ],
            ),
            content: CustomTextFormField(
              hintText: 'Enter Name',
              keyboardType: TextInputType.text,
              controller: controller.updateName,
              validator:
                  (value) => value!.isEmpty ? 'Name cannot be empty' : null,
              onChanged: (value) {
                controller.updateName.text = value;
                controller.extractName(value);
                controller.updateName.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.length),
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 8,
                ),
                child: CustomGradientButton(
                  text: 'Update',
                  onPressed: () {
                    print('StoreTemplateView: Update name button pressed');
                    if (controller.updateName.text.isNotEmpty) {
                      controller.extractName(controller.updateName.text);
                      Get.closeAllSnackbars();
                      Get.back(closeOverlays: true);
                      ();
                    } else {
                      Get.snackbar('Error', 'Please enter a valid name');
                    }
                  },
                ),
              ),
            ],
          ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('StoreTemplateView: Close button tapped');
        Get.back();
        ();
      },
      child: const Icon(Icons.close, color: AppColors.error),
    );
  }
}

class _CloseDialogButton extends StatelessWidget {
  const _CloseDialogButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('StoreTemplateView: Close dialog tapped');
        Get.back();
        ();
      },
      child: Icon(Icons.close_sharp, color: AppColors.primaryGradinatMixColor),
    );
  }
}

class _SelectedIndicator extends StatelessWidget {
  const _SelectedIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryGradinatMixColor, width: 2),
      ),
      child: CircleAvatar(
        radius: 13,
        backgroundColor: AppColors.white,
        child: Icon(
          Icons.check_sharp,
          color: AppColors.primaryGradinatMixColor,
          size: 15,
        ),
      ),
    );
  }
}

class _ProfileAndBannerSection extends StatelessWidget {
  final StoreTemplateController controller;

  const _ProfileAndBannerSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(child: _ProfileWidget(controller: controller)),
          Expanded(child: _MainBannerWidget(controller: controller)),
        ],
      ),
    );
  }
}

class _ProfileWidget extends StatelessWidget {
  final StoreTemplateController controller;

  const _ProfileWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print('StoreTemplateView: Logo upload tapped');
            controller.pickImage(ImageSource.gallery, true);
          },
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: CircleAvatar(
              radius: 62,
              backgroundColor: Colors.transparent,
              child: ClipOval(child: _LogoImage(controller: controller)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Profile',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        // TextButton(
        //   onPressed: () {
        //     print('StoreTemplateView: Upload Logo button pressed');
        //     controller.pickImage(ImageSource.gallery, true);
        //   },
        //   child: Text(
        //     'Upload Logo',
        //     style: GoogleFonts.montserrat(
        //       fontSize: 14,
        //       color: AppColors.primaryGradinatMixColor,
        //       decoration: TextDecoration.underline,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _LogoImage extends StatelessWidget {
  final StoreTemplateController controller;

  const _LogoImage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.logoImage.value != null
              ? Image.file(
                controller.logoImage.value!,
                fit: BoxFit.cover,
                width: 124,
                height: 124,
                errorBuilder: (context, error, stackTrace) {
                  print(
                    'StoreTemplateView: Error loading logo image: $error, path: ${controller.logoImage.value?.path}',
                  );
                  return ClipOval(
                    child: Image.asset(
                      'assets/images/Null_ticket.png',
                      fit: BoxFit.cover,
                      width: 124,
                      height: 124,
                    ),
                  );
                },
              )
              : controller.logos.isNotEmpty &&
                  controller.selectedLogoIndex.value < controller.logos.length
              ? Image.network(
                controller
                    .logos[controller.selectedLogoIndex.value]
                    .bannerImage,
                fit: BoxFit.cover,
                width: 124,
                height: 124,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  print(
                    'StoreTemplateView: Error loading logo template: $error',
                  );
                  return ClipOval(
                    child: Image.asset(
                      'assets/images/Null_ticket.png',
                      fit: BoxFit.cover,
                      width: 124,
                      height: 124,
                    ),
                  );
                },
              )
              : ClipOval(
                child: Image.asset(
                  'assets/images/Null_ticket.png',
                  fit: BoxFit.cover,
                  width: 124,
                  height: 124,
                ),
              ),
    );
  }
}

class _MainBannerWidget extends StatelessWidget {
  final StoreTemplateController controller;

  const _MainBannerWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print('StoreTemplateView: Banner upload tapped');
            controller.pickImage(ImageSource.gallery, false);
          },
          child: SizedBox(
            height: 125,
            child: Stack(
              children: [
                Obx(
                  () =>
                      controller.bannerImage.value != null
                          ? Image.file(
                            controller.bannerImage.value!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 125,
                            errorBuilder: (context, error, stackTrace) {
                              print(
                                'StoreTemplateView: Error loading banner image: $error, path: ${controller.bannerImage.value?.path}',
                              );
                              return Image.asset(
                                'assets/images/Null_ticket.png',
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: 125,
                              );
                            },
                          )
                          : controller.banners.isNotEmpty &&
                              controller.selectedBannerIndex.value <
                                  controller.banners.length
                          ? Image.network(
                            controller
                                .banners[controller.selectedBannerIndex.value]
                                .bannerImage,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 125,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              print(
                                'StoreTemplateView: Error loading banner template: $error',
                              );
                              return Image.asset(
                                'assets/images/Null_ticket.png',
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: 125,
                              );
                            },
                          )
                          : Image.asset(
                            'assets/images/Null_ticket.png',
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 125,
                          ),
                ),
                Positioned(
                  top: 15,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: controller.firstName.value,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: controller.lastName.value,
                            style: GoogleFonts.montserrat(
                              color: AppColors.primaryGradinatMixColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Banner',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        // TextButton(
        //   onPressed: () {
        //     print('StoreTemplateView: Upload Banner button pressed');
        //     controller.pickImage(ImageSource.gallery, false);
        //   },
        //   child: Text(
        //     'Upload Banner',
        //     style: GoogleFonts.montserrat(
        //       fontSize: 14,
        //       color: AppColors.primaryGradinatMixColor,
        //       decoration: TextDecoration.underline,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _DividerWithOr extends StatelessWidget {
  const _DividerWithOr();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(thickness: 0.5, color: AppColors.border, indent: 15),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 0.5,
            color: AppColors.border,
            endIndent: 15,
          ),
        ),
      ],
    );
  }
}

class _EditNameButton extends StatelessWidget {
  final VoidCallback onTap;

  const _EditNameButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Text(
          'Edit Profile & Banner Name',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryGradinatMixColor,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primaryGradinatMixColor,
          ),
        ),
      ),
    );
  }
}

class _TemplateSection extends StatelessWidget {
  final String title;
  final bool isEmpty;
  final Widget child;

  const _TemplateSection({
    required this.title,
    required this.isEmpty,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 10),
        isEmpty
            ? Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'No ${title.toLowerCase().replaceAll(':', '')} available',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: AppColors.error,
                ),
              ),
            )
            : child,
      ],
    );
  }
}

class _LogoTemplates extends StatelessWidget {
  final StoreTemplateController controller;

  const _LogoTemplates({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.logos.length,
        itemBuilder: (context, index) {
          final template = controller.logos[index];
          return GestureDetector(
            onTap: () {
              print('StoreTemplateView: Logo template $index selected');
              controller.selectedLogoIndex.value = index;
              controller.logoImage.value = null;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 135,
                    width: 135,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      child: Image.network(
                        template.bannerImage,
                        fit: BoxFit.cover, // Fixed fit for logo templates
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const CircularProgressIndicator();
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print(
                            'StoreTemplateView: Error loading logo template: $error',
                          );
                          return ClipOval(
                            child: Image.asset(
                              'assets/images/Null_ticket.png',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () =>
                        controller.selectedLogoIndex.value == index &&
                                controller.logoImage.value == null
                            ? const Positioned(
                              right: 10,
                              child: _SelectedIndicator(),
                            )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BannerTemplates extends StatelessWidget {
  final StoreTemplateController controller;

  const _BannerTemplates({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.banners.length,
        itemBuilder: (context, index) {
          final template = controller.banners[index];
          return GestureDetector(
            onTap: () {
              print('StoreTemplateView: Banner template $index selected');
              controller.selectedBannerIndex.value = index;
              controller.bannerImage.value = null;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 190,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Image.network(
                      template.bannerImage,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print(
                          'StoreTemplateView: Error loading banner template: $error',
                        );
                        return Image.asset(
                          'assets/images/Null_ticket.png',
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 0,
                    right: 0,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: controller.firstName.value,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: controller.lastName.value,
                            style: GoogleFonts.montserrat(
                              color: AppColors.primaryGradinatMixColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () =>
                        controller.selectedBannerIndex.value == index &&
                                controller.bannerImage.value == null
                            ? const Positioned(
                              right: 5,
                              top: 5,
                              child: _SelectedIndicator(),
                            )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String type;

  const _ErrorWidget({required this.type});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoreTemplateController>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Failed to load $type',
            style: GoogleFonts.montserrat(
              color: AppColors.error,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
              print('StoreTemplateView: Retry $type load');
              controller.refresh();
            },
            child: Text(
              'Retry',
              style: GoogleFonts.montserrat(
                color: AppColors.primaryGradinatMixColor,
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
