class ApiConfig {
  // Base URL configuration
  static const String baseUrl =
      'http://localhost/instachow_admin_panel_backend';

  // API Endpoints
  static const String masterCategoriesEndpoint = '/master_categories.php';
  static const String subCategoryEndpoint = '/sub_categories.php';
  static const String nutritionMasterEndpoint = '/nutrition_master.php';
  static const String allergenMasterEndpoint = '/allergen_master.php';

  // Complete URLs
  static String get masterCategoriesUrl => '$baseUrl$masterCategoriesEndpoint';
  static String get subCategoryUrl => '$baseUrl$subCategoryEndpoint';
  static String get nutritionMasterUrl => '$baseUrl$nutritionMasterEndpoint';
  static String get allergenMasterUrl => '$baseUrl$allergenMasterEndpoint';

  // Debug configuration
  static const bool enableDebugLogs = true;

  // Helper method to log debug messages
  static void debugLog(String message) {
    if (enableDebugLogs) {
      print('[API_DEBUG] ${DateTime.now()}: $message');
    }
  }
}
