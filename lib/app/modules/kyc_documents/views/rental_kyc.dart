import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/kyc_documents/controllers/rental_kyc_controller.dart';
import 'package:farmitra/app/modules/kyc_documents/views/owner_upload_doc.dart';
import 'package:farmitra/app/modules/kyc_documents/views/owners_details.dart';
import 'package:farmitra/app/modules/login/views/login_view.dart';
import 'package:farmitra/app/modules/registration/controllers/store_details_form_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class RentalKyc extends StatelessWidget {
  RentalKyc({super.key});
  final RentalKycController rentalKycController = Get.put(
    RentalKycController(),
  );
  final StoreDetailsFormController storeDetailsFormController = Get.put(
    StoreDetailsFormController(),
  );
  @override
  Widget build(BuildContext context) {
    var categoryName = Get.arguments;
    final box = GetStorage();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Future.microtask(() async {
            final shouldExit =
                await Get.dialog<bool>(
                  AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Do you want to close the app?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          box.erase();
                          Get.offAll(() => LoginView()); // navigate to login
                          Get.back(result: true); // return true to PopScope
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ) ??
                false;

            if (shouldExit) {
              SystemNavigator.pop();
            }
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          automaticallyImplyLeading: true,
          onHelpTap: () {
            Get.toNamed('/help-center');
          },
          onTranslateTap: () {
            Get.toNamed('/add');
          },
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeDetailsFormController.categoryName == 'Expert'
                      ? 'A. Profession Details'
                      : 'A. Business Details',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please upload at least one document.',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            '/select_document',
                            // arguments: categoryName,
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Color(0xffDADADA)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  storeDetailsFormController.categoryName ==
                                          'Expert'
                                      ? 'Select Qualification'
                                      : 'Select a document',
                                ),
                              ),
                              Icon(Icons.arrow_right_sharp, size: 30),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffDADADA)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Document Must show:',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.check, size: 20),
                                      Text(
                                        storeDetailsFormController
                                                    .categoryName ==
                                                'Expert'
                                            ? '  Degree Name'
                                            : '  Registration Number',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.check, size: 20),
                                      Text(
                                        storeDetailsFormController
                                                    .categoryName ==
                                                'Expert'
                                            ? '  Document Number'
                                            : '  Legal Name',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.check, size: 20),
                                      Text(
                                        storeDetailsFormController
                                                    .categoryName ==
                                                'Expert'
                                            ? '  Expert Name'
                                            : '  Trade Name',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: 'Sample',
                                    titlePadding: EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                      right: 10,
                                      bottom: 0,
                                    ),
                                    titleStyle: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.primaryGradinatMixColor,
                                    ),
                                    content: Image.asset(
                                      storeDetailsFormController.categoryName ==
                                              'Expert'
                                          ? 'assets/images/degree_sample_image.jpg'
                                          : 'assets/images/gst_certificate_sample_image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.border),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        storeDetailsFormController
                                                    .categoryName ==
                                                'Expert'
                                            ? 'assets/images/degree_sample_image.jpg'
                                            : 'assets/images/gst_certificate_sample_image.jpg',
                                      ),
                                      fit: BoxFit.fill,
                                      opacity: 0.2,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.visibility),
                                      Text(
                                        'View Sample',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
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
                      storeDetailsFormController.categoryName != 'Expert'
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                'Store photos:',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Take or upload clear photos of your store or shop.',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _showImagePickerDialog(
                                              'inside',
                                            ); // Choose for inside image
                                          },
                                          child: Column(
                                            children: [
                                              Obx(
                                                () => DottedBorder(
                                                  strokeWidth: 1,
                                                  borderType: BorderType.RRect,
                                                  dashPattern: [6, 3],
                                                  color: Color(0xffAEAEAE),
                                                  radius: Radius.circular(15),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 10,
                                                        ),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          rentalKycController
                                                                      .insideImage
                                                                      .value !=
                                                                  null
                                                              ? Image.file(
                                                                rentalKycController
                                                                    .insideImage
                                                                    .value!,
                                                                height: 100,
                                                                width: 100,
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
                                                              )
                                                              : SvgPicture.asset(
                                                                'assets/icons/uploadicon.svg',
                                                              ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            'Upload Inside Image',
                                                            style:
                                                                GoogleFonts.montserrat(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            'JPEG, PNG less than\n15MB',
                                                            style:
                                                                GoogleFonts.montserrat(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Inside',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff636363),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _showImagePickerDialog(
                                              'outside',
                                            ); // Choose for outside image
                                          },
                                          child: Column(
                                            children: [
                                              Obx(
                                                () => DottedBorder(
                                                  strokeWidth: 1,
                                                  borderType: BorderType.RRect,
                                                  dashPattern: [6, 3],
                                                  color: Color(0xffAEAEAE),
                                                  radius: Radius.circular(15),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 10,
                                                        ),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          rentalKycController
                                                                      .outsideImage
                                                                      .value !=
                                                                  null
                                                              ? Image.file(
                                                                rentalKycController
                                                                    .outsideImage
                                                                    .value!,
                                                                height: 100,
                                                                width: 100,
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
                                                              )
                                                              : SvgPicture.asset(
                                                                'assets/icons/uploadicon.svg',
                                                              ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            'Upload Outside Image',
                                                            style:
                                                                GoogleFonts.montserrat(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            'JPEG, PNG less than\n15MB',
                                                            style:
                                                                GoogleFonts.montserrat(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Outside',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff636363),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Color(0xffDADADA),
                                    ),
                                  ),
                                  Text(
                                    '&',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Color(0xffDADADA),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  storeDetailsFormController.categoryName == 'Expert'
                      ? "B. Expert's details"
                      : "B. Owner's details",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please upload at least one document.',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.to(OwnersDetails());
                          // Get.to(OwnerUploadDoc());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Color(0xffDADADA)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('     Select a document'),
                              Icon(Icons.arrow_right_sharp, size: 30),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffDADADA)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Document Must show:',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.check, size: 20),
                                      Text(' Full Name'),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.check, size: 20),
                                      Text(' Photo '),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.check, size: 20),
                                      Text(' ID Number'),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: '',
                                    titlePadding: EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                      right: 10,
                                      bottom: 0,
                                    ),
                                    titleStyle: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Color(0xffF27129),
                                    ),
                                    content: Image.asset(
                                      'assets/images/Aadhar.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color(0xffDADADA),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/Aadhar.jpg',
                                      ),
                                      fit: BoxFit.fill,
                                      opacity: 0.2,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.visibility),
                                      Text(
                                        'View Sample',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
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
                      storeDetailsFormController.categoryName != 'Expert'
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                "Owner's photos",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Take or upload clear photo in front also inside of your store or shop.',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        _showImagePickerDialog(
                                          'ownerWithFrontShop',
                                        ); // Choose for outside image
                                      },
                                      child: Column(
                                        children: [
                                          Obx(
                                            () => DottedBorder(
                                              strokeWidth: 1,
                                              borderType: BorderType.RRect,
                                              dashPattern: [6, 3],
                                              color: Color(0xffAEAEAE),
                                              radius: Radius.circular(15),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 10,
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      rentalKycController
                                                                  .ownerWithFrontShop
                                                                  .value !=
                                                              null
                                                          ? Image.file(
                                                            rentalKycController
                                                                .ownerWithFrontShop
                                                                .value!,
                                                            height: 100,
                                                            width: 100,
                                                            fit: BoxFit.cover,
                                                          )
                                                          : SvgPicture.asset(
                                                            'assets/icons/uploadicon.svg',
                                                            fit: BoxFit.fill,
                                                          ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        'Upload Inside Image',
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        'JPEG, PNG less than\n               10MB',
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Front of the\nStore or shop',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff636363),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        _showImagePickerDialog(
                                          'ownerWithInsideShop',
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Obx(
                                            () => DottedBorder(
                                              strokeWidth: 1,
                                              borderType: BorderType.RRect,
                                              dashPattern: [6, 3],
                                              color: Color(0xffAEAEAE),
                                              radius: Radius.circular(15),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 10,
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      rentalKycController
                                                                  .ownerWithInsideShop
                                                                  .value !=
                                                              null
                                                          ? Image.file(
                                                            rentalKycController
                                                                .ownerWithInsideShop
                                                                .value!,
                                                            height: 100,
                                                            width: 100,
                                                            fit: BoxFit.cover,
                                                          )
                                                          : SvgPicture.asset(
                                                            'assets/icons/uploadicon.svg',
                                                            fit: BoxFit.fill,
                                                          ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        'Upload Outside Image',
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        'JPEG, PNG less than\n               10MB',
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Inside of the\nStore or shop',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff636363),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          )
                          : SizedBox.fromSize(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryFirstGradiant,
                        AppColors.primarySecondGradiant,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.toNamed('/bank-details');
                    },
                    child: Text(
                      'Save & Next',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/bank-details',
                    // arguments: previousPageGridTitle
                  );
                },
                child: Text(
                  'Skip for now!',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

void _showImagePickerDialog(String type) {
  final RentalKycController rentalKycController = Get.put(
    RentalKycController(),
  );

  showDialog(
    context: Get.context!, // Since you're using GetX
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Select Image:-',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryGradinatMixColor,
          ),
        ),
        // content: Column(
        //   mainAxisSize: MainAxisSize.min, // To avoid the dialog being too large
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     // If you need to add additional content here
        //   ],
        // ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  (); // Close dialog
                  rentalKycController.captureImage(type);
                },
                child: Text(
                  'Camera',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  (); // Close dialog
                  rentalKycController.uploadFromGallery(type);
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
