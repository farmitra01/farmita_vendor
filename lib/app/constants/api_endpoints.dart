class ApiEndpoints {
  // Base URL for the API
  // static const String baseUrl = 'http://192.168.1.2:8000/api'; // Local base URL
  static const String baseUrl = 'https://api.farmitra.in/api';
  static const String stagingBaseUrl = 'https://staging.farmitra.in/api';
  static const bool isProduction = true;
  static String get effectiveBaseUrl => isProduction ? baseUrl : stagingBaseUrl;

  // API endpoints
  final String _baseImageUrl = 'https://api.farmitra.in/storage/';
  // static const String login = '/login';
  static const String userLoginWithOtp = '/userlogin-with-otp';
  static const String verifyOtp = '/login/verify-otp';
  static const String getPendingAppointments =
      '/expert/get-farmer-query-by-status?query_status=1&query_type=1';
  static const String addPostByExpert = '/add-post-by-user';
  static const String getPost = '/get-post';
  static const String getpostvideo = '/get-video-post';
  static const String getBlogNews = '/get-blogs';
  static const String getBlogNewsDetails = '/view-blogs-by-id/';
  static const String reportPost = '/report-post';
  static const String commentOnPost = '/post-comment';
  static const String fetchComments = '/all-comments-in-post/{post_id}';
  static const String fetchBusinessModule = '/business-modules';
  static const String fetchModuleCategories = '/module-category/{id}';
  static const String fetchFaqs = '/faqs/grouped';
  static const String fetchGreviancesCategory = '/grievance-categories';
  static const String postSubmitGreviances = '/submit-grievance';
  static const String fetchGrevienceTicket = '/my-grievances';
  static const String fetchRegistrationMedia = '/vendor-media';
  static const String addvender = '/add-vendor';
  static const String addUpiDetails = '/add-upi-details';
  static const String addBankDetails = '/add-bank-details';
  static const String addBusinessDocument = '/add-business-document';
  static const String addOwnerDocument = '/add-owner-document';
  static const String getBusinessPlans = '/plans';
  static const String getUserPost = '/get-user-post';
  static const String deleteUsertPost = '/delete-post';
  static const String getUserDetails = '/vendor/{id}';
  static const String addExpertQuery = '/expert/query';
  static const String GetPostTags = '/get-post-tags';

  get getGrievancesCategoryUrl => null;
  // Construct full URL
  static String getFullUrl(String endpoint) => '$effectiveBaseUrl$endpoint';

  // Format dynamic endpoints (e.g., /api/posts/123)
  static String formatEndpoint(String endpoint, Map<String, String>? params) {
    String formatted = endpoint;
    if (params != null) {
      params.forEach((key, value) {
        formatted = formatted.replaceAll('{$key}', value);
      });
    }
    return formatted;
  }
}
