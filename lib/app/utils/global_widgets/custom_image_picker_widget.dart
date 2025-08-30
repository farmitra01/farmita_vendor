import 'dart:io';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUploadImageWidget extends StatefulWidget {
  final String label;
  final String size;
  final Function(File?)? onImagePicked;
  final double height;
  final double width;
  final Widget? padding;

  const CustomUploadImageWidget({
    Key? key,
    required this.label,
    required this.size,
    this.onImagePicked,
    this.height = 100,
    this.width = 100,
    this.padding,
  }) : super(key: key);

  @override
  _CustomUploadImageWidgetState createState() =>
      _CustomUploadImageWidgetState();
}

class _CustomUploadImageWidgetState extends State<CustomUploadImageWidget> {
  File? _selectedImage;

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  ();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  ();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Trigger callback if provided
      if (widget.onImagePicked != null) {
        widget.onImagePicked!(_selectedImage);
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: DottedBorder(
        radius: Radius.circular(15),
        borderType: BorderType.RRect,
        color: AppColors.border,
        child: Container(
          height: widget.height,
          width: widget.width,
          child:
              _selectedImage != null
                  ? Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: widget.width,
                    height: widget.height,
                  )
                  : Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/uploadicon.svg'),
                      SizedBox(height: 5),
                      Text(
                        widget.label, // Custom label
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.size,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
