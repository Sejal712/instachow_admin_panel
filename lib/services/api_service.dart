import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  
  // Get all food categories
  static Future<List<Map<String, dynamic>>> getFoodCategories({String? module}) async {
    try {
      String url = ApiConfig.masterCategoriesUrl;
      
      // Add module parameter if specified
      if (module != null && module.isNotEmpty && module != 'all') {
        url += '?module=$module';
      }
      
      // Add cache-busting parameter
      String separator = url.contains('?') ? '&' : '?';
      url += '${separator}t=${DateTime.now().millisecondsSinceEpoch}';
      
      ApiConfig.debugLog('Fetching food categories from: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
        },
      );

      ApiConfig.debugLog('Food categories response status: ${response.statusCode}');
      ApiConfig.debugLog('Food categories response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        
        if (data['success'] == true) {
          List<Map<String, dynamic>> categories = List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog('Successfully retrieved ${categories.length} categories');
          return categories;
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch food categories');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: Failed to fetch food categories');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getFoodCategories: $e');
      rethrow;
    }
  }
  
  // Add new food category with image upload
  static Future<Map<String, dynamic>> addFoodCategory({
    required String name,
    String? iconUrl,
    File? imageFile,
    String? module,
  }) async {
    try {
      ApiConfig.debugLog('Starting addFoodCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.masterCategoriesEndpoint}');
      ApiConfig.debugLog('Category name: $name');
      ApiConfig.debugLog('Icon URL: ${iconUrl ?? "none provided"}');
      ApiConfig.debugLog('Module: ${module ?? 'Food'}');
      ApiConfig.debugLog('Image file: ${imageFile?.path ?? "none provided"}');
      
      http.Response response;
      
      if (imageFile != null) {
        // Create multipart request for image upload
        var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.masterCategoriesEndpoint));
        
        // Add text fields
        request.fields['name'] = name;
        request.fields['module'] = module ?? 'Food';
        if (iconUrl != null && iconUrl.isNotEmpty) {
          request.fields['icon_url'] = iconUrl;
        }
        
        // Debug: Log all fields being sent
        ApiConfig.debugLog('Multipart fields: ${request.fields}');
        
        // Add image file
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ));
        
        // Debug: Log file info
        ApiConfig.debugLog('Multipart files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}');
        ApiConfig.debugLog('Sending multipart request with image');
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Regular JSON request without image
        final requestBody = {
          'name': name,
          'icon_url': iconUrl ?? '',
          'module': module ?? 'Food',
        };
        ApiConfig.debugLog('Request body: $requestBody');
        
        response = await http.post(
          Uri.parse(ApiConfig.masterCategoriesEndpoint),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );
      }
      
      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        
        if (data['success']) {
          ApiConfig.debugLog('Category added successfully: ${data['data']}');
          return data['data'];
        } else {
          ApiConfig.debugLog('Failed to add category - API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog('HTTP request failed with status: ${response.statusCode}');
        throw Exception('Failed to add food category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in addFoodCategory: $e');
      throw Exception('Error: $e');
    }
  }
  
  // Update food category with image upload support
  static Future<Map<String, dynamic>> updateFoodCategory({
    required int id,
    required String name,
    File? imageFile,
  }) async {
    try {
      ApiConfig.debugLog('Starting updateFoodCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.masterCategoriesEndpoint}');
      ApiConfig.debugLog('Category ID: $id');
      ApiConfig.debugLog('Category name: $name');
      ApiConfig.debugLog('Image file: ${imageFile?.path ?? 'null'}');
      
      http.Response response;
      
      if (imageFile != null) {
        // Create multipart request for image upload (use POST with method override for PHP compatibility)
        var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.masterCategoriesEndpoint));
        
        // Add text fields
        request.fields['_method'] = 'PUT'; // Method override for PHP
        request.fields['id'] = id.toString();
        request.fields['name'] = name;
        
        // Debug: Log all fields being sent
        ApiConfig.debugLog('Multipart fields: ${request.fields}');
        
        // Add image file
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ));
        
        // Debug: Log file info
        ApiConfig.debugLog('Multipart files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}');
        ApiConfig.debugLog('Sending multipart request with image');
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Regular JSON request without image
        final requestBody = {
          'id': id,
          'name': name,
        };
        ApiConfig.debugLog('Request body: $requestBody');
        
        response = await http.put(
          Uri.parse(ApiConfig.masterCategoriesEndpoint),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );
      }
      
      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        
        if (data['success']) {
          ApiConfig.debugLog('Category updated successfully: ${data['data']}');
          return data['data'];
        } else {
          ApiConfig.debugLog('Failed to update category - API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog('HTTP request failed with status: ${response.statusCode}');
        throw Exception('Failed to update food category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in updateFoodCategory: $e');
      throw Exception('Error: $e');
    }
  }
  
  // Delete food category
  static Future<bool> deleteFoodCategory(int id) async {
    try {
      ApiConfig.debugLog('Starting deleteFoodCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.masterCategoriesEndpoint}');
      ApiConfig.debugLog('Category ID to delete: $id');
      
      final requestBody = {'id': id};
      ApiConfig.debugLog('Request body: $requestBody');
      
      final response = await http.delete(
        Uri.parse(ApiConfig.masterCategoriesUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      
      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        ApiConfig.debugLog('Delete success: ${data['success']}');
        return data['success'];
      } else {
        ApiConfig.debugLog('HTTP request failed with status: ${response.statusCode}');
        throw Exception('Failed to delete food category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deleteFoodCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Sub-Category CRUD Methods
  
  // Get all sub-categories
  static Future<List<Map<String, dynamic>>> getSubCategories({String? masterCatId}) async {
    try {
      ApiConfig.debugLog('Starting getSubCategories request');
      String url = ApiConfig.subCategoryUrl;
      if (masterCatId != null) {
        url += '?master_cat_id=$masterCatId';
      }
      ApiConfig.debugLog('Request URL: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      
      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        
        if (data['success']) {
          final subCategories = List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog('Successfully retrieved ${subCategories.length} sub-categories');
          return subCategories;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog('HTTP request failed with status: ${response.statusCode}');
        throw Exception('Failed to load sub-categories');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getSubCategories: $e');
      throw Exception('Error: $e');
    }
  }
  
  // Add new sub-category
  static Future<Map<String, dynamic>> addSubCategory({
    required String name,
    String? description,
    required String masterCatId,
  }) async {
    try {
      ApiConfig.debugLog('Starting addSubCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.subCategoryUrl}');
      ApiConfig.debugLog('Sub-category name: $name');
      ApiConfig.debugLog('Description: ${description ?? "none provided"}');
      ApiConfig.debugLog('Master Category ID: $masterCatId');
      
      final requestBody = {
        'name': name,
        'description': description ?? '',
        'master_cat_food_id': masterCatId,
      };
      ApiConfig.debugLog('Request body: $requestBody');
      
      final response = await http.post(
        Uri.parse(ApiConfig.subCategoryUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: requestBody,
      );
      
      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        
        if (data['success']) {
          ApiConfig.debugLog('Sub-category added successfully');
          return data;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog('HTTP request failed with status: ${response.statusCode}');
        throw Exception('Failed to add sub-category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in addSubCategory: $e');
      throw Exception('Error: $e');
    }
  }
  
  // Update sub-category
  static Future<Map<String, dynamic>> updateSubCategory({
    required String id,
    required String name,
    String? description,
    required String masterCatId,
  }) async {
    try {
      ApiConfig.debugLog('Starting updateSubCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.subCategoryUrl}');
      ApiConfig.debugLog('Sub-category ID: $id');
      ApiConfig.debugLog('Sub-category name: $name');
      ApiConfig.debugLog('Description: ${description ?? "none provided"}');
      ApiConfig.debugLog('Master Category ID: $masterCatId');
      
      final requestBody = {
        'id': id,
        'name': name,
        'description': description ?? '',
        'master_cat_food_id': masterCatId,
        '_method': 'PUT',
      };
      ApiConfig.debugLog('Request body: $requestBody');
      
      final response = await http.post(
        Uri.parse(ApiConfig.subCategoryUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: requestBody,
      );
      
      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        
        if (data['success']) {
          ApiConfig.debugLog('Sub-category updated successfully');
          return data;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog('HTTP request failed with status: ${response.statusCode}');
        throw Exception('Failed to update sub-category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in updateSubCategory: $e');
      throw Exception('Error: $e');
    }
  }
  
  // Delete sub-category
  static Future<bool> deleteSubCategory(String id) async {
    try {
      ApiConfig.debugLog('Starting deleteSubCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.subCategoryUrl}');
      ApiConfig.debugLog('Sub-category ID to delete: $id');
      
      final response = await http.delete(
        Uri.parse('${ApiConfig.subCategoryUrl}?id=$id'),
        headers: {'Content-Type': 'application/json'},
      );
      
      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        ApiConfig.debugLog('Delete success: ${data['success']}');
        return data['success'];
      } else {
        ApiConfig.debugLog('HTTP request failed with status: ${response.statusCode}');
        throw Exception('Failed to delete sub-category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deleteSubCategory: $e');
      throw Exception('Error: $e');
    }
  }
  
  // Get master categories by module for sub-category dropdown
  static Future<List<Map<String, dynamic>>> getMasterCategoriesByModule({required String module}) async {
    try {
      ApiConfig.debugLog('Starting getMasterCategoriesByModule request');
      // Add cache-busting parameter
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String url = '${ApiConfig.subCategoryUrl}?action=master_categories&module=$module&_t=$timestamp';
      ApiConfig.debugLog('Request URL: $url');
      ApiConfig.debugLog('Module filter: $module');
      ApiConfig.debugLog('Full URL being called: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
        },
      );
      
      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');
        
        if (data['success']) {
          final categories = List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog('Successfully retrieved ${categories.length} master categories for $module');
          ApiConfig.debugLog('Categories received: ${categories.map((c) => c['name']).toList()}');
          return categories;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog('HTTP request failed with status: ${response.statusCode}');
        throw Exception('Failed to load master categories');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getMasterCategoriesByModule: $e');
      throw Exception('Error: $e');
    }
  }
}
