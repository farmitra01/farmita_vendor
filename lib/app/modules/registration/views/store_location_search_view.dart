import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_search_controller.dart';

class StoreLocationSearchView extends StatelessWidget {
  final StoreSearchLocationController controller = Get.put(
    StoreSearchLocationController(),
  );
  final TextEditingController searchField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌍 Map
          FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              onMapReady: controller.onMapReady,
              onTap: (tapPos, latLng) {
                controller.selectedLocation.value = latLng;
                controller.mapController.move(latLng, 15);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              Obx(() {
                final point = controller.selectedLocation.value;
                if (point == null) return MarkerLayer(markers: []);
                return MarkerLayer(
                  markers: [
                    Marker(
                      width: 40,
                      height: 40,
                      point: point,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),

          /// 🔍 Search UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      controller: searchField,
                      onSubmitted: controller.searchLocation,
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            searchField.clear();
                            controller.searchResults.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  /// 📋 Search Results
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (controller.searchResults.isEmpty) {
                      return SizedBox.shrink();
                    }
                    return Container(
                      height: 300,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final item = controller.searchResults[index];
                          return ListTile(
                            title: Text(
                              item['display_name'],
                              style: GoogleFonts.montserrat(fontSize: 13),
                            ),
                            onTap: () {
                              controller.selectLocation(item);
                            },
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),

      /// 📍 Use Current Location Button
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () async {
            await controller.getCurrentLocationAndAddress();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.only(bottom: 180, left: 20),
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

      /// 📝 Confirm & Proceed Bottom Sheet
      bottomSheet: Obx(() {
        final address = controller.searchedSelectedLocation.value;
        if (address.isEmpty) return SizedBox.shrink();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, -3),
              ),
            ],
          ),
          height: 175,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.pin_drop_outlined,
                    color: AppColors.primaryGradinatMixColor,
                    size: 35,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      address,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGradinatMixColor,
                      ),

                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomGradientButton(
                text: 'Confirm & Proceed',
                onPressed: controller.confirmSelection,
              ),
            ],
          ),
        );
      }),
    );
  }
}
