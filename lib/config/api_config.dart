class ApiConfig {
  static const String baseUrl =
      'http://localhost/instachow_admin_panel_backend';

  // Food endpoints
  static const String foodCategoriesEndpoint = '/food_categories.php';
  static const String foodSubCategoriesEndpoint = '/food_sub_categories.php';
  
  // Grocery endpoints
  static const String groceryCategoriesEndpoint = '/grocery_categories.php';
  static const String grocerySubCategoriesEndpoint = '/grocery_sub_categories.php';
  
  // Legacy endpoints (for backward compatibility)
  static const String masterCategoriesEndpoint = '/master_categories.php';
  static const String subCategoryEndpoint = '/sub_categories.php';

  // Food URLs
  static String get foodCategoriesUrl => '$baseUrl$foodCategoriesEndpoint';
  static String get foodSubCategoriesUrl => '$baseUrl$foodSubCategoriesEndpoint';
  
  // Grocery URLs
  static String get groceryCategoriesUrl => '$baseUrl$groceryCategoriesEndpoint';
  static String get grocerySubCategoriesUrl => '$baseUrl$grocerySubCategoriesEndpoint';
  
  // Legacy URLs
  static String get masterCategoriesUrl => '$baseUrl$masterCategoriesEndpoint';
  static String get subCategoryUrl => '$baseUrl$subCategoryEndpoint';

  static const bool enableDebugLogs = true;

  static void debugLog(String message) {
    if (enableDebugLogs) {
      print('[API_DEBUG] ${DateTime.now()}: $message');
    }
  }
}
