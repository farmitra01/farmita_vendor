import 'dart:ffi';
import 'dart:math';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/inventory/controllers/edit_product_controller.dart';
import 'package:farmitra/app/modules/inventry/controllers/add_rental_item_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddRentalItem extends StatelessWidget {
  AddRentalItem({super.key});
  final AddRentalItemController addRentalItemController = Get.put(
    AddRentalItemController(),
  );
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Add rental Item',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: GradientSvgIcon(
                    icon: Icon(Icons.close),
                    size: 30,
                    gradient: LinearGradient(
                      colors: [Color(0xffF27129), Color(0xffA3410A)],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'All related details associated with the product',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(thickness: .5),
              SizedBox(height: 10),
              Obx(() {
                return addRentalItemController.selectedImages.isEmpty
                    ? Stack(
                      children: [
                        // Placeholder container when no images are selected
                        Container(
                          height: 330,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            'assets/images/Null_image.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Add image button
                        Positioned(
                          bottom: 0,
                          right: 20,
                          child: GestureDetector(
                            onTap: () {
                              Get.dialog(buildAlertBox(Get.context!));
                            },
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryFirstGradiant,
                                    AppColors.primarySecondGradiant,
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppColors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : Stack(
                      children: [
                        // Grid displaying selected images
                        Container(
                          height: 330,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              var count =
                                  addRentalItemController.selectedImages.length;
                              if (index == 3) {
                                // Nested Grid at 3rd index
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 4,
                                        mainAxisSpacing: 4,
                                      ),
                                  itemCount: 4,
                                  // Example: Nested grid with 4 items
                                  itemBuilder: (context, nestedIndex) {
                                    var count =
                                        addRentalItemController
                                            .selectedImages
                                            .length;
                                    return Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child:
                                                addRentalItemController
                                                            .selectedImages
                                                            .isEmpty ||
                                                        count <= nestedIndex + 3
                                                    ? Image.asset(
                                                      addRentalItemController
                                                          .nestedImagePaths[index],
                                                      fit: BoxFit.fill,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    )
                                                    : Image.file(
                                                      addRentalItemController
                                                          .selectedImages[nestedIndex +
                                                          3],
                                                      fit: BoxFit.fill,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 25,
                                          right: 20,
                                          child: GestureDetector(
                                            onTap: () {
                                              addRentalItemController
                                                  .selectedImages
                                                  .removeAt(index);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.error,
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: AppColors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              return Stack(
                                children: [
                                  Card(
                                    child:
                                        addRentalItemController
                                                    .selectedImages
                                                    .isEmpty ||
                                                count <= index
                                            ? Image.asset(
                                              addRentalItemController
                                                  .nestedImagePaths[index],
                                              fit: BoxFit.fill,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                            : Image.file(
                                              addRentalItemController
                                                  .selectedImages[index],
                                              fit: BoxFit.fill,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                  ),
                                  // Remove image button
                                  Positioned(
                                    top: 60,
                                    right: 60,
                                    child: GestureDetector(
                                      onTap: () {
                                        addRentalItemController.selectedImages
                                            .removeAt(index);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.error,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: AppColors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
              }),

              SizedBox(height: 10),
              Text(
                'Note: Please Upload Front , back , side ,and Number plate image of vehical',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGradinatMixColor,
                ),
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Obx(() {
                    return Checkbox(
                      activeColor: AppColors.primaryGradinatMixColor,
                      value: addRentalItemController.isAvailable.value,
                      onChanged: (value) {
                        addRentalItemController.isAvailable.value =
                            !addRentalItemController.isAvailable.value;
                      },
                    );
                  }),
                  GradientText(
                    text: 'Available ',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryFirstGradiant,
                        AppColors.primarySecondGradiant,
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  GradientSvgIcon(
                    assetName: 'assets/svgs/gift_bw.svg',
                    size: 20,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryFirstGradiant,
                        AppColors.primarySecondGradiant,
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "A. Rental Details: ",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                hintText: "Rental Name",
                keyboardType: TextInputType.text,
                inputFormatters: [],
                controller: addRentalItemController.producName,
                validator: (p0) {},
              ),
              SizedBox(height: 10),
              Obx(() {
                return CustomDropdown(
                  hint: "Brand",
                  items: ['FlipKart', 'Amazon', 'Meesho', 'BlinkIt', 'Zepto'],
                  selectedItem: addRentalItemController.brand.value,
                  onChanged: (value) {
                    if (value != null) {
                      addRentalItemController.brand.value = value;
                    }
                  },
                  itemBuilder: (item) => item,
                );
              }),
              SizedBox(height: 10),
              Obx(() {
                return CustomDropdown<String>(
                  hint: 'Medel',
                  items: ['Sonalika', 'Mahindra', 'JSV'],
                  selectedItem: addRentalItemController.storeChannel.value,
                  onChanged: (value) {
                    if (value != null) {
                      addRentalItemController.storeChannel.value = value;
                    }
                  },
                  itemBuilder: (item) => item.toString(),
                );
              }),
              SizedBox(height: 10),
              Obx(() {
                return CustomDropdown(
                  hint: 'Category',
                  items: [
                    'Category-1',
                    'Category-2',
                    'Category-3',
                    'Category-4',
                    'Category-4',
                  ],
                  selectedItem: addRentalItemController.category.value,
                  onChanged: (value) {
                    if (value != null) {
                      addRentalItemController.category.value = value;
                    }
                  },
                  itemBuilder: (item) => item,
                );
              }),
              SizedBox(height: 10),
              Obx(() {
                return CustomDropdown(
                  hint: 'Sub-Category',
                  items: [
                    'Sub-Category-1',
                    'Sub-Category-2',
                    'Sub-Category-3',
                    'Sub-Category-4',
                    'Sub-Category-4',
                  ],
                  selectedItem: addRentalItemController.sub_category.value,
                  onChanged: (value) {
                    if (value != null) {
                      addRentalItemController.sub_category.value = value;
                    }
                  },
                  itemBuilder: (item) => item,
                );
              }),
              // SizedBox(height: 10),
              // CustomTextFormField(
              //   hintText: 'Rental Price in INR(₹)',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [],
              //   controller: addRentalItemController.product_price,
              //   validator: (p0) {},
              // ),
              // SizedBox(height: 5),
              // CustomTextFormField(
              //   hintText: 'Rental Discription',
              //   keyboardType: TextInputType.text,
              //   inputFormatters: [],
              //   controller: addRentalItemController.productDiscription,
              //   validator: (p0) {},
              //   minLines: 4,
              //   maxLines: 4,
              //   borderRadius: 20,
              // ),
              // SizedBox(height: 10),
              // CustomTextFormField(
              //   hintText: 'Tax Amount Included',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [],
              //   controller: addRentalItemController.tax_amount,
              //   validator: (p0) {},
              // ),
              // SizedBox(height: 10),
              // Obx(() {
              //   return CustomDropdown(
              //     hint: 'Product Unit',
              //     items: ['Mili Gram', 'Kilo Gram', 'Quintal', 'Tonne'],
              //     selectedItem: addRentalItemController.product_unit.value,
              //     onChanged: (value) {
              //       if (value != null) {
              //         addRentalItemController.product_unit.value = value;
              //       }
              //     },
              //     itemBuilder: (item) => item,
              //   );
              // }),
              // SizedBox(height: 10),
              // CustomTextFormField(
              //   hintText: 'Discount (In Percentage/Rupees)',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [],
              //   controller: addRentalItemController.discount,
              //   validator: (value) {},
              // ),
              // SizedBox(height: 10),
              // CustomTextFormField(
              //   hintText: 'Max Purchase Limit (Count)',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [],
              //   controller: addRentalItemController.max_limit,
              //   validator: (value) {},
              // ),
              // SizedBox(height: 10),
              // CustomTextFormField(
              //   hintText: 'SKU,s',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [],
              //   controller: addRentalItemController.SKUs,
              //   validator: (value) {},
              // ),
              // SizedBox(height: 10),
              // Obx(() {
              //   return CustomDropdown(
              //     hint: 'Availability',
              //     items: ['For take away only', 'Dine-in only', 'Both options'],
              //     selectedItem: addRentalItemController.availbility.value,
              //     onChanged: (value) {
              //       if (value != null) {
              //         addRentalItemController.availbility.value = value;
              //       }
              //     },
              //     itemBuilder: (item) => item,
              //   );
              // }),
              // SizedBox(height: 20),
              // Text(
              //   "B. Additional Details:",
              //   style: GoogleFonts.montserrat(
              //     fontSize: 14,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // SizedBox(height: 20),
              // Obx(() {
              //   return CustomTextFormField(
              //     hintText: 'Purchase Price (Tax)',
              //     keyboardType: TextInputType.number,
              //     inputFormatters: [],
              //     controller: addRentalItemController.purchase_price_tax,
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter purchase price';
              //       }
              //       return null;
              //     },
              //     maxLines: 1,
              //     minLines: 1,
              //     suffixWidget: SizedBox(
              //       width: 163,
              //       child: CustomDropdown(
              //         hint: 'Tax',
              //         items: ['Tax Included', 'Tax Excluded'],
              //         selectedItem:
              //             ['Tax Included', 'Tax Excluded'].contains(
              //                   addRentalItemController.purchasePriceTax.value,
              //                 )
              //                 ? addRentalItemController.purchasePriceTax.value
              //                 : 'Tax Included',
              //         onChanged: (value) {
              //           if (value != null) {
              //             addRentalItemController.purchasePriceTax.value =
              //                 value;
              //           }
              //         },
              //         itemBuilder: (item) => item,
              //         showBorder: false,
              //         selectedItemColor: AppColors.primaryGradinatMixColor,
              //       ),
              //     ),
              //   );
              // }),
              // SizedBox(height: 10),
              // CustomTextFormField(
              //   hintText: 'HSN Code (Product)/SAC Code (Service)',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [],
              //   controller: addRentalItemController.hsn_Code,
              //   validator: (value) {},
              // ),
              // SizedBox(height: 10),
              // CustomTextFormField(
              //   hintText: 'Assign Barcode',
              //   keyboardType: TextInputType.streetAddress,
              //   inputFormatters: [],
              //   controller: addRentalItemController.assign_barcode,
              //   validator: (value) {},
              //   suffixWidget: Icon(
              //     Icons.barcode_reader,
              //     color: AppColors.primaryGradinatMixColor,
              //   ),
              // ),
              // SizedBox(height: 20),
              Text(
                " Search Tags:",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 300,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.border),
                ),
                child: SingleChildScrollView(
                  // Makes the entire column scrollable
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selected:",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Selected List
                      Obx(() {
                        return addRentalItemController.selectedItems.length != 0
                            ? ListView.builder(
                              shrinkWrap: true,
                              physics:
                                  NeverScrollableScrollPhysics(), // Prevents nested scrolling conflicts
                              itemCount:
                                  (addRentalItemController
                                              .selectedItems
                                              .length /
                                          2)
                                      .ceil(),
                              itemBuilder: (context, index) {
                                int firstIndex = index * 2;
                                int secondIndex = firstIndex + 1;

                                return Row(
                                  children: [
                                    if (firstIndex <
                                        addRentalItemController
                                            .selectedItems
                                            .length)
                                      _buildChip(
                                        addRentalItemController
                                            .selectedItems[firstIndex],
                                        true,
                                      ),
                                    if (secondIndex <
                                        addRentalItemController
                                            .selectedItems
                                            .length)
                                      _buildChip(
                                        addRentalItemController
                                            .selectedItems[secondIndex],
                                        true,
                                      ),
                                  ],
                                );
                              },
                            )
                            : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                child: Text(
                                  'Choose Keyword from Given below Available Section',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            );
                      }),
                      SizedBox(height: 10),
                      Text(
                        "Available:",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      // Available List
                      Obx(
                        () => ListView.builder(
                          shrinkWrap: true, // Makes the list fit its content
                          physics:
                              NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
                          itemCount:
                              (addRentalItemController.availableItems.length /
                                      2)
                                  .ceil(),
                          itemBuilder: (context, index) {
                            int firstIndex = index * 2;
                            int secondIndex = firstIndex + 1;
                            return Row(
                              children: [
                                if (firstIndex <
                                    addRentalItemController
                                        .availableItems
                                        .length)
                                  _buildChip(
                                    addRentalItemController
                                        .availableItems[firstIndex],
                                    false,
                                  ),
                                if (secondIndex <
                                    addRentalItemController
                                        .availableItems
                                        .length)
                                  _buildChip(
                                    addRentalItemController
                                        .availableItems[secondIndex],
                                    false,
                                  ),
                              ],
                            );
                          },
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
      bottomNavigationBar: Container(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            CustomGradientButton(text: "Add Product", onPressed: () {}),
            SizedBox(height: 10),
            GradientText(
              text: 'Save for later',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryFirstGradiant,
                  AppColors.primarySecondGradiant,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildChip(String text, bool isSelected) {
  final AddRentalItemController addRentalItemController = Get.put(
    AddRentalItemController(),
  );
  return Container(
    padding: EdgeInsets.only(left: 10),
    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(35),
      color: Color(0xfff3f0ec),
    ),
    child: Row(
      children: [
        Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 5),
        IconButton(
          onPressed: () {
            if (isSelected) {
              addRentalItemController.removeItem(text);
            } else {
              addRentalItemController.selectItem(text);
            }
          },
          icon: Icon(
            isSelected ? Icons.cancel_outlined : Icons.add_circle_outline,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}

Widget buildAlertBox(BuildContext context) {
  final AddRentalItemController addRentalItemController = Get.put(
    AddRentalItemController(),
  );

  return AlertDialog(
    title: Text("Upload Image"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt, color: AppColors.lightskyBlue),
          title: Text("Take a Photo"),
          onTap: () => addRentalItemController.pickImages(ImageSource.camera),
        ),
        ListTile(
          leading: Icon(Icons.photo_library, color: AppColors.green),
          title: Text("Choose from Gallery"),
          onTap: () => addRentalItemController.pickImages(ImageSource.gallery),
        ),
      ],
    ),
    actions: [
      TextButton(
        child: Text("Cancel"),
        onPressed: () => Get.back(), // Use GetX to close the dialog
      ),
    ],
  );
}
