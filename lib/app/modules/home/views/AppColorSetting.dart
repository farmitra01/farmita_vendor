import 'package:farmitra/app/modules/home/controllers/appColorSetting.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColorSetting extends GetView<AppcolorsettingController> {
  const AppColorSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final AppcolorsettingController appcolorsettingController = Get.put(
      AppcolorsettingController(),
    );
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [ 
                          
              CustomTextFormField(
                hintText: 'hintText',
                keyboardType: TextInputType.text,
                controller: controller.appbarColor,
                validator: (p0) {},
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'hintText',
                keyboardType: TextInputType.text,
                controller: controller.gradianMixColor,
                validator: (p0) {},
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'hintText',
                keyboardType: TextInputType.text,
                controller: controller.buttonFirstGradiantColor,
                validator: (p0) {},
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'hintText',
                keyboardType: TextInputType.text,
                controller: controller.buttonSecondGradiatColor,
                validator: (p0) {},
              ),
            ],
          ),
        );
      },
    );
  }
}
