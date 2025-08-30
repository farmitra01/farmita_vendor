import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/khata_book/controllers/Add_customer_controller.dart';
import 'package:farmitra/app/modules/khata_book/views/khata_book_view.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomer extends StatelessWidget {
  AddCustomer({super.key});
  final AddCustomerController addCustomerController = Get.put(
    AddCustomerController(),
  );
  var tabindex = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print('Tab index value ${tabindex}');
    return Scaffold(
      appBar: VendorAppBar(
        title: tabindex == 0 ? 'Add Customer' : 'Add Suppliers',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: 'Enter Name',
              keyboardType: TextInputType.text,
              controller: addCustomerController.name,
              validator: (p0) {},
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              prefixWidget: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  '+91',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              hintText: 'Enter Number',
              keyboardType: TextInputType.text,
              controller: addCustomerController.number,
              validator: (p0) {},
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Enter Gst Number (optional)',
              keyboardType: TextInputType.text,
              controller: addCustomerController.gst,
              validator: (p0) {},
            ),
            SizedBox(height: 10),
            Obx(
              () => Row(
                children: [
                  Text(
                    'Who are they?',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Customer',
                        groupValue: addCustomerController.selectedRole.value,
                        onChanged:
                            (value) => addCustomerController.setRole(value!),
                        activeColor: AppColors.primaryGradinatMixColor,
                      ),
                      Text(
                        'Customer',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Supplier',
                        groupValue: addCustomerController.selectedRole.value,
                        onChanged:
                            (value) => addCustomerController.setRole(value!),
                        activeColor: AppColors.primaryGradinatMixColor,
                      ),
                      Text(
                        'Supplier',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomGradientButton(
                text: tabindex == 0 ? 'Add Customer' : 'Add Supplier',
                onPressed: () {
                  final name = addCustomerController.name.text;
                  final number = addCustomerController.number.text;
                  final gst = addCustomerController.gst.text;
                  final role = addCustomerController.selectedRole.value;

                  // Optional: basic check without trimming
                  if (name.isEmpty || number.isEmpty) {
                    Get.snackbar(
                      "Missing Info",
                      "Please enter name and number",
                    );
                    return;
                  }

                  final data = {
                    'name': name,
                    'number': number,
                    'role': role,
                    'money': 0,
                    if (gst.isNotEmpty) 'gst': gst,
                  };

                  Get.to(KhataBookView(), arguments: data);
                  addCustomerController.name.clear();
                  addCustomerController.number.clear();
                  addCustomerController.gst.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
