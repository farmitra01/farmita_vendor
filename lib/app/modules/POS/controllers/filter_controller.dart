import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FilterController extends GetxController{

   final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final RxInt selectedSidebarIndex = 0.obs;

  // Reactive maps
  final RxMap<String, bool> categorySelections = {
    'All Category': false,
    'Groceries': false,
    'Dairy Products': false,
    'Snacks & Beverages': false,
    'Personal Care': false,
    'Household Items': false,
    'Organic Products': false,
  }.obs;

  final RxMap<String, bool> dietarySelections = {
    'Show All': false,
    'Vegetarian': false,
    'Non-Vegetarian': false,
    'Vegan': false,
    'Gluten Free': false,
    'Organic': false,
  }.obs;

  final RxMap<String, bool> priceRange = {
    'Price Range': false,
    'Under ₹500': false,
    '₹500 - ₹1000': false,
    '₹1000 - ₹2500': false,
    '₹2500 - ₹5000': false,
    'Above ₹5000': false,
  }.obs;

  final RxMap<String, bool> rating = {
    'rattings': false,
    '1 star & above': false,
    '2 star & above': false,
    '3 star & above': false,
    '4 star & above': false,
    '5 star Only': false,
  }.obs;

  final RxMap<String, bool> delivery = {
    'Delievery': false,
    'Same Day Delivery': false,
    'Next Day Delivery': false,
    'Standart Day Delivery': false,
  }.obs;

  // Sidebar options
  final List<String> sidebarOptions = [
    'Category',
    'Dietary Preference',
    'Price Range',
    'Rating',
    'Delivery'
  ];

  // Reset all filters
  void resetFilters() {
    categorySelections.updateAll((key, value) => false);
    dietarySelections.updateAll((key, value) => false);
    priceRange.updateAll((key, value) => false);
    rating.updateAll((key, value) => false);
    delivery.updateAll((key, value) => false);
  }
}