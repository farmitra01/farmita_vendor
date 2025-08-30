import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/add_post-controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPostController addPostcontroller = Get.put(AddPostController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: VendorAppBar(title: 'Add Post'),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: "What's in your mind?",
                keyboardType: TextInputType.text,
                controller: addPostcontroller.comment,
                validator: addPostcontroller.validateComment(),
                maxLines: 3,
                borderRadius: 10,
              ),
              const SizedBox(height: 5),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${addPostcontroller.commentLength.value}/100',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Select tags',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: Obx(
                  () => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: addPostcontroller.postTags.map((tag) {
                      bool isSelected =
                          addPostcontroller.selectedTags.contains(tag.name);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            addPostcontroller.selectedTags.remove(tag.name);
                          } 
                          // else {
                          //   addPostcontroller.selectedTags.add(tag.name);
                          // }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected
                                ? AppColors.primaryGradinatMixColor
                                : AppColors.white,
                            border: isSelected
                                ? null
                                : Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            tag.name ?? '',
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () {
                  _uploadImagesDialog();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: DottedBorder(
                    color: AppColors.border,
                    dashPattern: const [6, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Obx(
                        () => addPostcontroller.selectedImages.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/uploadicon.svg',
                                  ),
                                  Text(
                                    'Upload Images',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'JPEG, PNG less than 15MB',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 250,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      addPostcontroller.selectedImages.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Image.file(
                                            addPostcontroller
                                                .selectedImages[index],
                                            height: 200,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                addPostcontroller
                                                    .selectedImages
                                                    .removeAt(index);
                                              },
                                              child: const Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: CustomGradientButton(
          text: 'Add Post',
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await addPostcontroller.addPost();
            }
          },
        ),
      ),
    );
  }
}

void _uploadImagesDialog() {
  final AddPostController addPostcontroller = Get.put(AddPostController());

  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Select Images',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryGradinatMixColor,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  addPostcontroller.pickImages();
                },
                child: Text(
                  'Gallery',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
