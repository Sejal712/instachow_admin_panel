import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {

  // Get all food categories
  static Future<List<Map<String, dynamic>>> getFoodCategories({String? module}) async {
    try {
      String url = ApiConfig.masterCategoriesUrl;

      if (module != null && module.isNotEmpty && module != 'all') {
        url += '?module=$module';
      }

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
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data']);
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

      http.Response response;

      if (imageFile != null) {
        var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.masterCategoriesUrl));

        request.fields['name'] = name;
        request.fields['module'] = module ?? 'Food';
        if (iconUrl != null && iconUrl.isNotEmpty) {
          request.fields['icon_url'] = iconUrl;
        }

        ApiConfig.debugLog('Multipart fields: ${request.fields}');

        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

        ApiConfig.debugLog('Multipart files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}');
        ApiConfig.debugLog('Sending multipart request with image');

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        final requestBody = {
          'name': name,
          'icon_url': iconUrl ?? '',
          'module': module ?? 'Food',
        };
        ApiConfig.debugLog('Request body: $requestBody');

        response = await http.post(
          Uri.parse(ApiConfig.masterCategoriesUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );
      }

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return data['data'];
        } else {
          throw Exception(data['message']);
        }
      } else {
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

      http.Response response;

      if (imageFile != null) {
        var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.masterCategoriesUrl));

        request.fields['_method'] = 'PUT';
        request.fields['id'] = id.toString();
        request.fields['name'] = name;

        ApiConfig.debugLog('Multipart fields: ${request.fields}');

        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

        ApiConfig.debugLog('Multipart files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}');
        ApiConfig.debugLog('Sending multipart request with image');

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        final requestBody = {
          'id': id,
          'name': name,
        };
        ApiConfig.debugLog('Request body: $requestBody');

        response = await http.put(
          Uri.parse(ApiConfig.masterCategoriesUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );
      }

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return data['data'];
        } else {
          throw Exception(data['message']);
        }
      } else {
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
      final requestBody = {'id': id};

      final response = await http.delete(
        Uri.parse(ApiConfig.masterCategoriesUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'];
      } else {
        throw Exception('Failed to delete food category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deleteFoodCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Get all sub-categories
  static Future<List<Map<String, dynamic>>> getSubCategories({String? masterCatId}) async {
    try {
      String url = ApiConfig.subCategoryUrl;
      if (masterCatId != null) {
        url += '?master_cat_id=$masterCatId';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return List<Map<String, dynamic>>.from(data['data']);
        } else {
          throw Exception(data['message']);
        }
      } else {
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
      final requestBody = {
        'name': name,
        'description': description ?? '',
        'master_cat_food_id': masterCatId,
      };

      final response = await http.post(
        Uri.parse(ApiConfig.subCategoryUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: requestBody,
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return data;
        } else {
          throw Exception(data['message']);
        }
      } else {
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
      final requestBody = {
        'id': id,
        'name': name,
        'description': description ?? '',
        'master_cat_food_id': masterCatId,
        '_method': 'PUT',
      };

      final response = await http.post(
        Uri.parse(ApiConfig.subCategoryUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: requestBody,
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return data;
        } else {
          throw Exception(data['message']);
        }
      } else {
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
      final response = await http.delete(
        Uri.parse('${ApiConfig.subCategoryUrl}?id=$id'),
        headers: {'Content-Type': 'application/json'},
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'];
      } else {
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
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String url = '${ApiConfig.subCategoryUrl}?action=master_categories&module=$module&_t=$timestamp';

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
        if (data['success']) {
          return List<Map<String, dynamic>>.from(data['data']);
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to load master categories');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getMasterCategoriesByModule: $e');
      throw Exception('Error: $e');
    }
  }
}
