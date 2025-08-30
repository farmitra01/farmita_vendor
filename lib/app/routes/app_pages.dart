import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../modules/Add_coupons/bindings/add_coupons_binding.dart';
import '../modules/Add_coupons/views/add_coupons_view.dart';
import '../modules/Advertisement/bindings/advertisement_binding.dart';
import '../modules/Advertisement/views/advertisement_view.dart';
import '../modules/Help_Center/views/faq_grid_pages_view.dart';
import '../modules/Help_Center/views/faq_view.dart';
import '../modules/Help_Center/views/help_center_view.dart';
import '../modules/Help_Center/views/text_support_view.dart';
import '../modules/Help_Center/views/ticket_view.dart';
import '../modules/Help_Center/views/video_tutorial_view.dart';
import '../modules/POS/bindings/pos_binding.dart';
import '../modules/POS/views/checkout.dart';
import '../modules/POS/views/pos_category_search_view.dart';
import '../modules/POS/views/pos_category_view.dart';
import '../modules/POS/views/pos_search_result_view.dart';
import '../modules/POS/views/pos_view.dart';
import '../modules/Wallet/bindings/wallet_binding.dart';
import '../modules/Wallet/views/wallet_view.dart';
import '../modules/bank_details/bindings/bank_details_binding.dart';
import '../modules/bank_details/views/bank_details_form_view.dart';
import '../modules/bank_details/views/bank_details_view.dart';
import '../modules/bank_details/views/thankyou_page_view.dart';
import '../modules/bank_details/views/upi_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_bottom_bar_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inventory/bindings/inventory_binding.dart';
import '../modules/inventory/views/inventory_view.dart';
import '../modules/inventry/bindings/inventry_binding.dart';
import '../modules/inventry/views/inventry_view.dart';
import '../modules/khata_book/bindings/khata_book_binding.dart';
import '../modules/khata_book/views/khata_book_view.dart';
import '../modules/kyc_documents/bindings/kyc_documents_binding.dart';
import '../modules/kyc_documents/views/business_kyc_view.dart';
import '../modules/kyc_documents/views/kyc_documents_view.dart';
import '../modules/kyc_documents/views/kyc_upload_document_view.dart';
import '../modules/kyc_documents/views/select_document_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/add_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/otp_view.dart';
import '../modules/owner_profile/views/owner_profile_view.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/registration/views/store_category_view.dart';
import '../modules/registration/views/store_details_form_view.dart';
import '../modules/registration/views/store_details_view.dart';
import '../modules/registration/views/store_location_search_view.dart';
import '../modules/registration/views/store_location_view.dart';
import '../modules/registration/views/store_selecte_module_view.dart';
import '../modules/registration/views/store_template_view.dart';
import '../modules/splashPage/bindings/splash_page_binding.dart';
import '../modules/splashPage/views/splash_page_view.dart';
import '../modules/storeProfile/bindings/store_profile_binding.dart';
import '../modules/storeProfile/views/about_view.dart';
import '../modules/storeProfile/views/review_view.dart';
import '../modules/storeProfile/views/store_profile_view.dart';
import '../modules/storeProfile/views/storesTabProfile_view.dart';

// import 'package:firstfind/app/modules/login/bindings/login_binging.dart';
// import 'package:firstfind/app/modules/login/view/loginView.dart';
// import 'package:firstfind/app/modules/login/view/otpView.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_PAGE;
  // static const INITIAL = Routes.OTP;
  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(name: _Paths.OTP, page: () => OtpView()),
    GetPage(name: _Paths.ADD, page: () => AddView()),
    GetPage(name: _Paths.HELP_CENTER, page: () => HelpCenterView()),
    GetPage(name: _Paths.text_support, page: () => TextSupportView()),
    GetPage(name: _Paths.faq, page: () => FaqView()),
    GetPage(name: _Paths.ticket, page: () => TicketView()),
    GetPage(name: _Paths.videotutorial, page: () => VideoTutorialView()),
    GetPage(
      name: _Paths.faq_grid_pages,
      page: () => FaqGridPagesView(Title: ' '),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      transition: Transition.upToDown,
    ),
    GetPage(name: _Paths.store_details, page: () => StoreDetailsView()),
    GetPage(
      name: _Paths.store_select_module,
      page: () => StoreSelectedModuleView(),
    ),
    GetPage(name: _Paths.store_category, page: () => StoreCategoryView()),
    GetPage(
      name: _Paths.store_details_form,
      page: () => StoreDetailsFormView(),
    ),
    GetPage(name: _Paths.store_template, page: () => StoreTemplateView()),
    GetPage(name: _Paths.store_location, page: () => StoreLocationView()),
    GetPage(
      name: _Paths.store_location_search,
      page: () => StoreLocationSearchView(),
    ),
    GetPage(
      name: _Paths.KYC_DOCUMENTS,
      page: () => KycDocumentsView(),
      binding: KycDocumentsBinding(),
    ),
    GetPage(name: _Paths.select_document, page: () => SelectDocumentView()),
    GetPage(
      name: _Paths.kyc_upload_document,
      page: () => KycUploadDocumentView(),
    ),
    GetPage(name: _Paths.business_kyc, page: () => BusinessKycView()),
    GetPage(
      name: _Paths.BANK_DETAILS,
      page: () => BankDetailsView(),
      binding: BankDetailsBinding(),
    ),
    GetPage(name: _Paths.upi_details, page: () => UpiDetailsView()),
    GetPage(name: _Paths.bank_details_form, page: () => BankDetailsFormView()),
    GetPage(name: _Paths.thankyou_page, page: () => ThankyouPageView()),
    GetPage(name: _Paths.HomeBottomBarView, page: () => HomeBottomBarView()),
    GetPage(
      name: _Paths.STORE_PROFILE,
      page: () => StoreProfileView(),
      binding: StoreProfileBinding(),
    ),
    GetPage(name: _Paths.StoresprofileView, page: () => StoresTabProfileView()),
    GetPage(name: _Paths.ReviewView, page: () => ReviewView()),
    GetPage(name: _Paths.AboutView, page: () => AboutView()),
    GetPage(name: _Paths.OWNER_PROFILE, page: () => OwnerProfileView()),
    GetPage(name: _Paths.POS, page: () => PosView(), binding: PosBinding()),
    GetPage(name: _Paths.Pos_category, page: () => PosCategoryView()),
    GetPage(
      name: _Paths.pos_category_search_view,
      page: () => PosCategorySearchView(),
    ),
    GetPage(
      name: _Paths.pos_Search_Result_view,
      page: () => PosSearchResultView(),
    ),
    GetPage(name: _Paths.checkout, page: () => Checkout()),
    GetPage(
      name: _Paths.INVENTORY,
      page: () => const InventoryView(),
      binding: InventoryBinding(),
    ),
    GetPage(
      name: _Paths.INVENTRY,
      page: () => InventryView(),
      binding: InventryBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.KHATA_BOOK,
      page: () => const KhataBookView(),
      binding: KhataBookBinding(),
    ),
    GetPage(
      name: _Paths.ADD_COUPONS,
      page: () => const AddCouponsView(),
      binding: AddCouponsBinding(),
    ),
    GetPage(
      name: _Paths.ADVERTISEMENT,
      page: () => const AdvertisementView(),
      binding: AdvertisementBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_PAGE,
      page: () => SplashPage(),
      binding: SplashPageBinding(),
    ),
  ];
}
