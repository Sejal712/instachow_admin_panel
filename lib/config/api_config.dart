class ApiConfig {
  static const String baseUrl = 'http://localhost/instachow_admin_panel_backend';
  
  static const String masterCategoriesEndpoint = '/master_categories.php';
  static const String subCategoryEndpoint = '/sub_categories.php';

  static String get masterCategoriesUrl => '$baseUrl$masterCategoriesEndpoint';
  static String get subCategoryUrl => '$baseUrl$subCategoryEndpoint';

  static const bool enableDebugLogs = true;

  static void debugLog(String message) {
    if (enableDebugLogs) {
      print('[API_DEBUG] ${DateTime.now()}: $message');
    }
  }
}
