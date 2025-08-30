import 'dart:ffi';
import 'dart:math';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/inventory/controllers/edit_product_controller.dart';
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

class EditProduct extends StatelessWidget {
  EditProduct({super.key});
  final EditProductController editProductController = Get.put(
    EditProductController(),
  );
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
                  'Edit Product',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
              ();
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryGradinatMixColor,
                child: Icon(Icons.close, color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(thickness: .5),
              SizedBox(height: 10),
              Obx(() {
                return editProductController.selectedImages.isEmpty
                    ? Stack(
                      children: [
                        // Placeholder container when no images are selected
                        Container(
                          height: 200,
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
                                  editProductController.selectedImages.length;
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
                                        editProductController
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
                                                editProductController
                                                            .selectedImages
                                                            .isEmpty ||
                                                        count <= nestedIndex + 3
                                                    ? Image.asset(
                                                      editProductController
                                                          .nestedImagePaths[index],
                                                      fit: BoxFit.fill,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    )
                                                    : Image.file(
                                                      editProductController
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
                                              editProductController
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
                                        editProductController
                                                    .selectedImages
                                                    .isEmpty ||
                                                count <= index
                                            ? Image.asset(
                                              editProductController
                                                  .nestedImagePaths[index],
                                              fit: BoxFit.fill,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                            : Image.file(
                                              editProductController
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
                                        editProductController.selectedImages
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
              // Row(
              //   children: [
              //     Obx(() {
              //       return Checkbox(
              //         activeColor: AppColors.primaryGradinatMixColor,
              //         value: editProductController.isAvailable.value,
              //         onChanged: (value) {
              //           editProductController.isAvailable.value =
              //               !editProductController.isAvailable.value;
              //         },
              //       );
              //     }),
              //     GradientText(
              //       text: 'Available For Gift',
              //       style: GoogleFonts.montserrat(
              //         fontSize: 15,
              //         fontWeight: FontWeight.w500,
              //       ),
              //       gradient: LinearGradient(
              //         colors: [
              //           AppColors.primaryFirstGradiant,
              //           AppColors.primarySecondGradiant,
              //         ],
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     GradientSvgIcon(
              //       assetName: 'assets/svgs/gift_bw.svg',
              //       size: 20,
              //       gradient: LinearGradient(
              //         colors: [
              //           AppColors.primaryFirstGradiant,
              //           AppColors.primarySecondGradiant,
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 10),
              Text(
                "A. Product Details:",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                hintText: 'Assign Barcode',
                keyboardType: TextInputType.streetAddress,
                inputFormatters: [],
                controller: editProductController.assign_barcode,
                validator: (value) {},
                suffixWidget: Icon(
                  Icons.barcode_reader,
                  color: AppColors.primaryGradinatMixColor,
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: "Product Name",
                keyboardType: TextInputType.text,
                inputFormatters: [],
                controller: editProductController.producName,
                validator: (p0) {},
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Product Discription',
                keyboardType: TextInputType.text,
                inputFormatters: [],
                controller: editProductController.productDiscription,
                validator: (p0) {},
                minLines: 4,
                maxLines: 4,
                borderRadius: 20,
              ),
              SizedBox(height: 10),
              // Obx(() {
              //   return CustomDropdown<String>(
              //     hint: 'Store Channel',
              //     items: ['Online', 'Offline', 'Both'],
              //     selectedItem: editProductController.storeChannel.value,
              //     onChanged: (value) {
              //       if (value != null) {
              //         editProductController.storeChannel.value = value;
              //       }
              //     },
              //     itemBuilder: (item) => item.toString(),
              //   );
              // }),
              SizedBox(height: 10),
              // Obx(() {
              //   return CustomDropdown(
              //     hint: "Brand",
              //     items: ['FlipKart', 'Amazon', 'Meesho', 'BlinkIt', 'Zepto'],
              //     selectedItem: editProductController.brand.value,
              //     onChanged: (value) {
              //       if (value != null) {
              //         editProductController.brand.value = value;
              //       }
              //     },
              //     itemBuilder: (item) => item,
              //   );
              // }),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    buildBottomSheet(
                      context: context,
                      title: 'Select Brand',
                      items: editProductController.brands,
                      onItemSelected: (selected) {
                        editProductController.selectedBrand.value = selected;
                      },
                    ), // <- Don't pass context; refactor function
                    isScrollControlled: true,
                    backgroundColor: Colors.white, // Optional
                  );
                },
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.border),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          editProductController.selectedBrand.value.isEmpty
                              ? 'Brand'
                              : editProductController.selectedBrand.value,
                          style: GoogleFonts.montserrat(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    buildBottomSheet(
                      context: context,
                      title: 'Select Category',
                      items: editProductController.categories,
                      onItemSelected: (selected) {
                        editProductController.selectedCategory.value = selected;
                      },
                    ), // <- Don't pass context; refactor function
                    isScrollControlled: true,
                    backgroundColor: Colors.white, // Optional
                  );
                },
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.border),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          editProductController.selectedCategory.value.isEmpty
                              ? 'Category'
                              : editProductController.selectedCategory.value,
                          style: GoogleFonts.montserrat(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    buildBottomSheet(
                      context: context,

                      title: 'Select Sub Category',
                      items: editProductController.subCatogory,
                      onItemSelected: (selected) {
                        editProductController.selectedSubCategory.value =
                            selected;
                      },
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.white, // Optional
                  );
                },

                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.border),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          editProductController
                                  .selectedSubCategory
                                  .value
                                  .isEmpty
                              ? 'Sub-Category'
                              : editProductController.selectedSubCategory.value,
                          style: GoogleFonts.montserrat(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'Product Price in INR(₹)',
                keyboardType: TextInputType.number,
                inputFormatters: [],
                controller: editProductController.product_price,
                validator: (p0) {},
              ),
              // Obx(() {
              //   return CustomTextFormField(
              //     hintText: ' Sale Price in INR(₹)',
              //     keyboardType: TextInputType.number,
              //     inputFormatters: [],
              //     controller: editProductController.product_price,
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter purchase price';
              //       }
              //       return null;
              //     },
              //     maxLines: 1,
              //     minLines: 1,
              //     suffixWidget: SizedBox(
              //       height: 20,
              //       width: 135,
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: CustomDropdown(
              //           hint: 'Tax',
              //           items: ['0%', '5%', '12%', '18%', '28%'],
              //           selectedItem:
              //               ['0%', '5%', '12%', '18%', '28%'].contains(
              //                     editProductController.product_priceTax.value,
              //                   )
              //                   ? editProductController.product_priceTax.value
              //                   : '0%', // Default fallback value
              //           onChanged: (value) {
              //             if (value != null) {
              //               editProductController.product_priceTax.value =
              //                   value;
              //             }
              //           },
              //           itemBuilder: (item) => item,
              //           showBorder: false,
              //           selectedItemColor: AppColors.primaryGradinatMixColor,
              //         ),
              //       ),
              //     ),
              //   );
              // }),
              SizedBox(height: 10),

              Obx(() {
                return CustomTextFormField(
                  hintText: 'Discount By',
                  keyboardType: TextInputType.number,
                  inputFormatters: [],
                  controller: editProductController.purchase_price_tax,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter purchase price';
                    }
                    return null;
                  },
                  maxLines: 1,
                  minLines: 1,
                  suffixWidget: SizedBox(
                    height: 30,
                    width: 170,
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: CustomDropdown(
                        hint: 'Tax',
                        items: ['Percent', 'Rupees'],
                        selectedItem:
                            ['Percent', 'Rupees'].contains(
                                  editProductController.purchasePriceTax.value,
                                )
                                ? editProductController.purchasePriceTax.value
                                : 'Percent',
                        onChanged: (value) {
                          if (value != null) {
                            editProductController.purchasePriceTax.value =
                                value;
                          }
                        },
                        itemBuilder: (item) => item,
                        showBorder: false,
                        selectedItemColor: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  ),
                );
              }),
              // CustomTextFormField(
              //   hintText: 'Discount (In Percentage/Rupees)',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [],
              //   controller: editProductController.discount,
              //   validator: (value) {},
              // ),
              SizedBox(height: 10),
              // Obx(() {
              //   return CustomDropdown(
              //     hint: 'Product Unit',
              //     items: ['Mili Gram', 'Kilo Gram', 'Quintal', 'Tonne'],
              //     selectedItem: editProductController.product_unit.value,
              //     onChanged: (value) {
              //       if (value != null) {
              //         editProductController.product_unit.value = value;
              //       }
              //     },
              //     itemBuilder: (item) => item,
              //   );
              // }),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    buildBottomSheet(
                      context: context,
                      title: 'Product Unit',
                      items: editProductController.productUnit,
                      onItemSelected: (selected) {
                        editProductController.selectedUnit.value = selected;
                      },
                    ), // <- Don't pass context; refactor function
                    isScrollControlled: true,
                    backgroundColor: Colors.white, // Optional
                  );
                },

                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.border),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          editProductController.selectedUnit.value.isEmpty
                              ? 'Product-Unit'
                              : editProductController.selectedUnit.value,
                          style: GoogleFonts.montserrat(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              CustomTextFormField(
                hintText: 'Max Purchase Limit (Count)',
                keyboardType: TextInputType.number,
                inputFormatters: [],
                controller: editProductController.max_limit,
                validator: (value) {},
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'SKU,s',
                keyboardType: TextInputType.number,
                inputFormatters: [],
                controller: editProductController.SKUs,
                validator: (value) {},
              ),
              SizedBox(height: 10),
              // Obx(() {
              //   return CustomDropdown(
              //     hint: 'Availability',
              //     items: ['For take away only', 'Dine-in only', 'Both options'],
              //     selectedItem: editProductController.availbility.value,
              //     onChanged: (value) {
              //       if (value != null) {
              //         editProductController.availbility.value = value;
              //       }
              //     },
              //     itemBuilder: (item) => item,
              //   );
              // }),
              SizedBox(height: 20),
              Text(
                "B. Additional Details:",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              // CustomTextFormField(
              //   hintText: 'Tax Amount Included',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [],
              //   controller: editProductController.tax_amount,
              //   validator: (p0) {},
              // ),
              Obx(() {
                return CustomTextFormField(
                  hintText: 'Sale Price(Tax)',
                  keyboardType: TextInputType.number,
                  inputFormatters: [],
                  controller: editProductController.purchase_price_tax,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter purchase price';
                    }
                    return null;
                  },
                  maxLines: 1,
                  minLines: 1,
                  suffixWidget: SizedBox(
                    height: 30,
                    width: 170,
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: CustomDropdown(
                        hint: 'Tax',
                        items: ['Tax Included', 'Tax Excluded'],
                        selectedItem:
                            ['Tax Included', 'Tax Excluded'].contains(
                                  editProductController.purchasePriceTax.value,
                                )
                                ? editProductController.purchasePriceTax.value
                                : 'Tax Included',
                        onChanged: (value) {
                          if (value != null) {
                            editProductController.purchasePriceTax.value =
                                value;
                          }
                        },
                        itemBuilder: (item) => item,
                        showBorder: false,
                        selectedItemColor: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 10),
              Obx(() {
                return CustomTextFormField(
                  hintText: 'Purchase Price(Tax)',
                  keyboardType: TextInputType.number,
                  inputFormatters: [],
                  controller: editProductController.purchase_price_tax,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter purchase price';
                    }
                    return null;
                  },
                  maxLines: 1,
                  minLines: 1,
                  suffixWidget: SizedBox(
                    height: 30,
                    width: 170,
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: CustomDropdown(
                        hint: 'Tax',
                        items: ['Tax Included', 'Tax Excluded'],
                        selectedItem:
                            ['Tax Included', 'Tax Excluded'].contains(
                                  editProductController.purchasePriceTax.value,
                                )
                                ? editProductController.purchasePriceTax.value
                                : 'Tax Included',
                        onChanged: (value) {
                          if (value != null) {
                            editProductController.purchasePriceTax.value =
                                value;
                          }
                        },
                        itemBuilder: (item) => item,
                        showBorder: false,
                        selectedItemColor: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 10),

              SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'HSN Code (Product)/SAC Code (Service)',
                keyboardType: TextInputType.number,
                inputFormatters: [],
                controller: editProductController.hsn_Code,
                validator: (value) {},
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    buildBottomSheet(
                      context: context,
                      title: 'GST Rate',
                      items: editProductController.gstRate,
                      onItemSelected: (selected) {
                        editProductController.selectedgst.value = selected;
                      },
                    ), // <- Don't pass context; refactor function
                    isScrollControlled: true,
                    backgroundColor: Colors.white, // Optional
                  );
                },

                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.border),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          editProductController.selectedgst.value.isEmpty
                              ? 'GST Rate'
                              : editProductController.selectedgst.value,
                          style: GoogleFonts.montserrat(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'C. Variation',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  editProductController.showVariationForm.value = true;
                  if (editProductController.variations.isEmpty) {
                    editProductController
                        .addVariation(); // first form by default
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.primaryGradinatMixColor),
                      SizedBox(height: 5),
                      Text(
                        'Want to Add Variation ?',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              // --- Variation Forms Section ---
              Obx(() {
                if (!editProductController.showVariationForm.value) {
                  return SizedBox.shrink();
                }

                return Column(
                  children: [
                    // Loop through variations
                    ...List.generate(editProductController.variations.length, (
                      index,
                    ) {
                      final variation = editProductController.variations[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Variation ${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (editProductController
                                            .variations
                                            .length ==
                                        1) {
                                      // if only one left, hide section
                                      editProductController
                                          .showVariationForm
                                          .value = false;
                                      editProductController.variations.clear();
                                    } else {
                                      editProductController.removeVariation(
                                        index,
                                      );
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.error
                                        .withOpacity(0.2),
                                    radius: 20,
                                    child: Icon(
                                      Icons.delete_forever_sharp,
                                      color: AppColors.error,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            CustomTextFormField(
                              validator: (p0) {},
                              keyboardType: TextInputType.text,
                              hintText: 'Assign Barcode',
                              controller: variation.assignBarcode,
                              suffixWidget: Icon(
                                Icons.barcode_reader,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    validator: (p0) {},

                                    hintText: 'Variation',
                                    keyboardType: TextInputType.number,
                                    controller: variation.variation,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: CustomTextFormField(
                                    validator: (p0) {},

                                    hintText: 'Price',
                                    keyboardType: TextInputType.number,
                                    controller: variation.price,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            CustomTextFormField(
                              validator: (p0) {},

                              hintText: 'Discount By',
                              keyboardType: TextInputType.number,
                              controller: variation.purchasePriceTax,
                              suffixWidget: SizedBox(
                                height: 30,
                                width: 170,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.5),
                                  child: Obx(() {
                                    return CustomDropdown(
                                      hint: 'Tax',
                                      items: ['Percent', 'Rupees'],
                                      selectedItem:
                                          variation.purchasePriceTaxType.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          variation.purchasePriceTaxType.value =
                                              value;
                                        }
                                      },
                                      itemBuilder: (item) => item,
                                      showBorder: false,
                                      selectedItemColor:
                                          AppColors.primaryGradinatMixColor,
                                    );
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            CustomTextFormField(
                              validator: (p0) {},
                              hintText: "SKU's",
                              keyboardType: TextInputType.number,
                              controller: variation.skus,
                            ),
                          ],
                        ),
                      );
                    }),

                    // --- Add Another Variation Button ---
                    TextButton(
                      onPressed: () {
                        editProductController.addVariation();
                      },
                      child: Text(
                        '+ Add Another Variation',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 15),
              Text(
                "D. Search Tags:",
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
                        return editProductController.selectedItems.length != 0
                            ? ListView.builder(
                              shrinkWrap: true,
                              physics:
                                  NeverScrollableScrollPhysics(), // Prevents nested scrolling conflicts
                              itemCount:
                                  (editProductController.selectedItems.length /
                                          2)
                                      .ceil(),
                              itemBuilder: (context, index) {
                                int firstIndex = index * 2;
                                int secondIndex = firstIndex + 1;

                                return Row(
                                  children: [
                                    if (firstIndex <
                                        editProductController
                                            .selectedItems
                                            .length)
                                      _buildChip(
                                        editProductController
                                            .selectedItems[firstIndex],
                                        true,
                                      ),
                                    if (secondIndex <
                                        editProductController
                                            .selectedItems
                                            .length)
                                      _buildChip(
                                        editProductController
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
                              (editProductController.availableItems.length / 2)
                                  .ceil(),
                          itemBuilder: (context, index) {
                            int firstIndex = index * 2;
                            int secondIndex = firstIndex + 1;

                            return Row(
                              children: [
                                if (firstIndex <
                                    editProductController.availableItems.length)
                                  _buildChip(
                                    editProductController
                                        .availableItems[firstIndex],
                                    false,
                                  ),
                                if (secondIndex <
                                    editProductController.availableItems.length)
                                  _buildChip(
                                    editProductController
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomGradientButton(text: "Add Product", onPressed: () {}),
      ),
    );
  }
}

Widget _buildChip(String text, bool isSelected) {
  final EditProductController editProductController = Get.put(
    EditProductController(),
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
              editProductController.removeItem(text);
            } else {
              editProductController.selectItem(text);
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
  final EditProductController editProductController = Get.put(
    EditProductController(),
  );

  return AlertDialog(
    title: Text("Upload Image"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt, color: AppColors.lightskyBlue),
          title: Text("Take a Photo"),
          onTap: () => editProductController.pickImages(ImageSource.camera),
        ),
        ListTile(
          leading: Icon(Icons.photo_library, color: AppColors.green),
          title: Text("Choose from Gallery"),
          onTap: () => editProductController.pickImages(ImageSource.gallery),
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

Widget buildBottomSheet({
  required BuildContext context,
  required String title,
  required List<String> items,
  required Function(String) onItemSelected,
}) {
  final EditProductController editProductController = Get.put(
    EditProductController(),
  );

  editProductController.filteredSuggestions.clear();
  editProductController.search.clear();

  return Container(
    height: MediaQuery.of(context).size.height * 0.7,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          hintText: 'Search',
          keyboardType: TextInputType.text,
          controller: editProductController.search,
          validator: (p0) {},
          suffixWidget: const Icon(Icons.search),
          onChanged: (value) {
            editProductController.updateSuggestions(items, value);
          },
        ),
        const SizedBox(height: 10),
        Obx(() {
          final suggestions = editProductController.filteredSuggestions;
          if (suggestions.isEmpty) return const SizedBox.shrink();
          return Expanded(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    onItemSelected(suggestions[index]);
                    editProductController.clearSuggestions();
                    Get.back();
                  },
                );
              },
            ),
          );
        }),
        Obx(() {
          if (editProductController.filteredSuggestions.isNotEmpty)
            return const SizedBox.shrink();
          return Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    onItemSelected(items[index]);
                    editProductController.clearSuggestions();
                    Get.back();
                  },
                );
              },
            ),
          );
        }),
      ],
    ),
  );
}
