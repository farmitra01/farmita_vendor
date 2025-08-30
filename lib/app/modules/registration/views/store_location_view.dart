import 'package:farmitra/app/modules/registration/views/store_location_search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';

class StoreLocationView extends GetView<StoreLocationController> {
  StoreLocationView({super.key});
final StoreLocationController storeLocationController = Get.put(
    StoreLocationController(),
  );
  
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Store Location',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.close, color: Color(0xffDB5050)),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(thickness: 1, color: Color(0xffDADADA)),
              // SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        final result = await Get.to(
                          () => StoreLocationSearchView(),
                        );
                        if (result != null && result is String) {
                          storeLocationController.updateAddressFromSearched(
                            result,
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search Location',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Icon(Icons.search),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xffDADADA)),
                          ),
                          child: Obx(() {
                            return FlutterMap(
                              mapController:
                                  storeLocationController.mapController,
                              options: MapOptions(
                                initialCenter:
                                    storeLocationController
                                        .selectedLocation
                                        .value,
                                initialZoom: 15,
                                onTap: (tapPosition, point) {
                                  storeLocationController.updateLocation(point);
                                },
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName:
                                      'com.farmitra.farmitra', // Add this!
                                ),
                                Obx(
                                  () => MarkerLayer(
                                    markers: [
                                      Marker(
                                        width: 40,
                                        height: 40,
                                        point:
                                            storeLocationController
                                                .selectedLocation
                                                .value,
                                        child: Icon(
                                          Icons.location_pin,
                                          color:
                                              AppColors.primaryGradinatMixColor,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap:
                                () =>
                                    storeLocationController
                                        .getCurrentLocation(),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white70,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.my_location,
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Use Current Location',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryGradinatMixColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color(0xffDADADA),
                          ),
                        ),
                        Text(
                          ' & ',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff636363),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color(0xffDADADA),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Enter complete address:',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: "Additional Address: Floor No / House No",
                      keyboardType: TextInputType.text,
                      controller: storeLocationController.additionalAddress,
                      validator: (value) {},
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: "Address",
                      keyboardType: TextInputType.text,
                      controller: storeLocationController.address,
                      validator:
                          (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Please Enter Address'
                                  : null,
                    ),
                    SizedBox(height: 15),

                    CustomTextFormField(
                      hintText: "Landmark",
                      keyboardType: TextInputType.text,
                      controller: storeLocationController.landmark,
                      validator: (value) {},
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: "Pin Code",
                      keyboardType: TextInputType.number,
                      controller: storeLocationController.pincode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Six Digit Pincode';
                        } else if (value.length != 6) {
                          return 'Please Enter Six Digit Pincode';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
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
            if (formkey.currentState!.validate()) {
              storeLocationController.CombinController();
              Get.back();
            }
          },
        ),
      ),
    );
  }
}
