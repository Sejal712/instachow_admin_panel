import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  // Get all pharmacy categories
  static Future<List<Map<String, dynamic>>> getPharmacyCategories() async {
    try {
      ApiConfig.debugLog('Starting getPharmacyCategories request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.pharmacyCategoriesUrl}');

      final response = await http.get(
        Uri.parse(ApiConfig.pharmacyCategoriesUrl),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
        },
      );

      ApiConfig.debugLog(
        'Pharmacy categories response status: ${response.statusCode}',
      );
      ApiConfig.debugLog('Pharmacy categories response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success'] == true) {
          List<Map<String, dynamic>> categories =
              List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog(
            'Successfully retrieved ${categories.length} pharmacy categories',
          );
          return categories;
        } else {
          throw Exception(
            data['message'] ?? 'Failed to fetch pharmacy categories',
          );
        }
      } else {
        throw Exception(
          'HTTP ${response.statusCode}: Failed to fetch pharmacy categories',
        );
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getPharmacyCategories: $e');
      rethrow;
    }
  }

  // Get all categories (Food, Grocery, Pharmacy)
  static Future<List<Map<String, dynamic>>> getFoodCategories({
    String? module,
  }) async {
    try {
      String url = ApiConfig.masterCategoriesUrl;

      // Add module parameter if specified
      if (module != null && module.isNotEmpty && module != 'all') {
        url += '?module=$module';
      }

      // Add cache-busting parameter
      String separator = url.contains('?') ? '&' : '?';
      url += '${separator}t=${DateTime.now().millisecondsSinceEpoch}';

      ApiConfig.debugLog(
        'Fetching categories from: $url (Module: ${module ?? 'all'})',
      );

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
        },
      );

      ApiConfig.debugLog('Categories response status: ${response.statusCode}');
      ApiConfig.debugLog('Categories response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success'] == true) {
          List<Map<String, dynamic>> categories =
              List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog(
            'Successfully retrieved ${categories.length} categories',
          );
          return categories;
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch categories');
        }
      } else {
        throw Exception(
          'HTTP ${response.statusCode}: Failed to fetch categories',
        );
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getFoodCategories: $e');
      rethrow;
    }
  }

  // Update pharmacy category with image upload support
  static Future<Map<String, dynamic>> updatePharmacyCategory({
    required int id,
    required String name,
    File? imageFile,
  }) async {
    try {
      ApiConfig.debugLog('Starting updatePharmacyCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.pharmacyCategoriesUrl}');
      ApiConfig.debugLog('Category ID: $id');
      ApiConfig.debugLog('Category name: $name');
      ApiConfig.debugLog('Image file: ${imageFile?.path ?? 'null'}');

      http.Response response;

      if (imageFile != null) {
        // Create multipart request for image upload (use POST with method override for PHP compatibility)
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(ApiConfig.pharmacyCategoriesUrl),
        );

        // Add text fields
        request.fields['_method'] = 'PUT'; // Method override for PHP
        request.fields['id'] = id.toString();
        request.fields['name'] = name;

        // Debug: Log all fields being sent
        ApiConfig.debugLog('Multipart fields: ${request.fields}');

        // Add image file
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );

        // Debug: Log file info
        ApiConfig.debugLog(
          'Multipart files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}',
        );
        ApiConfig.debugLog('Sending multipart request with image');
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Regular JSON request without image
        final requestBody = {'id': id, 'name': name};
        ApiConfig.debugLog('Request body: $requestBody');

        response = await http.put(
          Uri.parse(ApiConfig.pharmacyCategoriesUrl),
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
          ApiConfig.debugLog(
            'Pharmacy category updated successfully: ${data['data']}',
          );
          return data['data'];
        } else {
          ApiConfig.debugLog(
            'Failed to update pharmacy category - API returned success=false: ${data['message']}',
          );
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to update pharmacy category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in updatePharmacyCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Delete pharmacy category
  static Future<bool> deletePharmacyCategory(int id) async {
    try {
      ApiConfig.debugLog('Starting deletePharmacyCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.pharmacyCategoriesUrl}');
      ApiConfig.debugLog('Category ID to delete: $id');

      final requestBody = {'id': id};
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.delete(
        Uri.parse(ApiConfig.pharmacyCategoriesUrl),
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
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to delete pharmacy category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deletePharmacyCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Get all pharmacy sub-categories
  static Future<List<Map<String, dynamic>>> getPharmacySubCategories() async {
    try {
      ApiConfig.debugLog('Starting getPharmacySubCategories request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.pharmacySubCategoriesUrl}');

      final response = await http.get(
        Uri.parse(ApiConfig.pharmacySubCategoriesUrl),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
        },
      );

      ApiConfig.debugLog(
        'Pharmacy sub-categories response status: ${response.statusCode}',
      );
      ApiConfig.debugLog(
        'Pharmacy sub-categories response body: ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success'] == true) {
          List<Map<String, dynamic>> subCategories =
              List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog(
            'Successfully retrieved ${subCategories.length} pharmacy sub-categories',
          );
          return subCategories;
        } else {
          throw Exception(
            data['message'] ?? 'Failed to fetch pharmacy sub-categories',
          );
        }
      } else {
        throw Exception(
          'HTTP ${response.statusCode}: Failed to fetch pharmacy sub-categories',
        );
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getPharmacySubCategories: $e');
      rethrow;
    }
  }

  // Get pharmacy main categories for sub-category creation
  static Future<List<Map<String, dynamic>>> getPharmacyMainCategories() async {
    try {
      ApiConfig.debugLog('Starting getPharmacyMainCategories request');
      final url = '${ApiConfig.pharmacySubCategoriesUrl}?main_categories=true';
      ApiConfig.debugLog('Request URL: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
        },
      );

      ApiConfig.debugLog(
        'Pharmacy main categories response status: ${response.statusCode}',
      );
      ApiConfig.debugLog(
        'Pharmacy main categories response body: ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success'] == true) {
          List<Map<String, dynamic>> categories =
              List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog(
            'Successfully retrieved ${categories.length} pharmacy main categories',
          );
          return categories;
        } else {
          throw Exception(
            data['message'] ?? 'Failed to fetch pharmacy main categories',
          );
        }
      } else {
        throw Exception(
          'HTTP ${response.statusCode}: Failed to fetch pharmacy main categories',
        );
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getPharmacyMainCategories: $e');
      rethrow;
    }
  }

  // Add new pharmacy sub-category
  static Future<Map<String, dynamic>> addPharmacySubCategory({
    required String name,
    String? description,
    required int masterCategoryId,
  }) async {
    try {
      ApiConfig.debugLog('Starting addPharmacySubCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.pharmacySubCategoriesUrl}');
      ApiConfig.debugLog('Sub-category name: $name');
      ApiConfig.debugLog('Description: ${description ?? "none provided"}');
      ApiConfig.debugLog('Master category ID: $masterCategoryId');

      final requestBody = {
        'name': name,
        'description': description ?? '',
        'master_category_id': masterCategoryId,
      };
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.post(
        Uri.parse(ApiConfig.pharmacySubCategoriesUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          ApiConfig.debugLog(
            'Pharmacy sub-category added successfully: ${data['data']}',
          );
          return data['data'];
        } else {
          ApiConfig.debugLog(
            'Failed to add pharmacy sub-category - API returned success=false: ${data['message']}',
          );
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to add pharmacy sub-category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in addPharmacySubCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Update pharmacy sub-category
  static Future<Map<String, dynamic>> updatePharmacySubCategory({
    required int id,
    required String name,
    String? description,
    required int masterCategoryId,
  }) async {
    try {
      ApiConfig.debugLog('Starting updatePharmacySubCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.pharmacySubCategoriesUrl}');
      ApiConfig.debugLog('Sub-category ID: $id');
      ApiConfig.debugLog('Sub-category name: $name');
      ApiConfig.debugLog('Description: ${description ?? "none provided"}');
      ApiConfig.debugLog('Master category ID: $masterCategoryId');

      final requestBody = {
        'id': id,
        'name': name,
        'description': description ?? '',
        'master_category_id': masterCategoryId,
      };
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.put(
        Uri.parse(ApiConfig.pharmacySubCategoriesUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          ApiConfig.debugLog(
            'Pharmacy sub-category updated successfully: ${data['data']}',
          );
          return data['data'];
        } else {
          ApiConfig.debugLog(
            'Failed to update pharmacy sub-category - API returned success=false: ${data['message']}',
          );
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to update pharmacy sub-category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in updatePharmacySubCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Delete pharmacy sub-category
  static Future<bool> deletePharmacySubCategory(int id) async {
    try {
      ApiConfig.debugLog('Starting deletePharmacySubCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.pharmacySubCategoriesUrl}');
      ApiConfig.debugLog('Sub-category ID to delete: $id');

      final requestBody = {'id': id};
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.delete(
        Uri.parse(ApiConfig.pharmacySubCategoriesUrl),
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
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to delete pharmacy sub-category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deletePharmacySubCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Add new pharmacy category with image upload
  static Future<Map<String, dynamic>> addPharmacyCategory({
    required String name,
    File? imageFile,
  }) async {
    try {
      ApiConfig.debugLog('Starting addPharmacyCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.pharmacyCategoriesUrl}');
      ApiConfig.debugLog('Category name: $name');
      ApiConfig.debugLog('Image file: ${imageFile?.path ?? "none provided"}');

      http.Response response;

      if (imageFile != null) {
        // Create multipart request for image upload
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(ApiConfig.pharmacyCategoriesUrl),
        );

        // Add text fields
        request.fields['name'] = name;

        // Debug: Log all fields being sent
        ApiConfig.debugLog('Multipart fields: ${request.fields}');

        // Add image file
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );

        // Debug: Log file info
        ApiConfig.debugLog(
          'Multipart files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}',
        );
        ApiConfig.debugLog('Sending multipart request with image');
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Regular JSON request without image
        final requestBody = {'name': name};
        ApiConfig.debugLog('Request body: $requestBody');

        response = await http.post(
          Uri.parse(ApiConfig.pharmacyCategoriesUrl),
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
          ApiConfig.debugLog(
            'Pharmacy category added successfully: ${data['data']}',
          );
          return data['data'];
        } else {
          ApiConfig.debugLog(
            'Failed to add pharmacy category - API returned success=false: ${data['message']}',
          );
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to add pharmacy category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in addPharmacyCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Add new category with image upload (Food, Grocery, Pharmacy)
  static Future<Map<String, dynamic>> addFoodCategory({
    required String name,
    String? iconUrl,
    File? imageFile,
    String? module,
  }) async {
    try {
      ApiConfig.debugLog('Starting addFoodCategory request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.masterCategoriesUrl}');
      ApiConfig.debugLog('Category name: $name');
      ApiConfig.debugLog('Icon URL: ${iconUrl ?? "none provided"}');
      ApiConfig.debugLog('Module: ${module ?? 'Food'}');
      ApiConfig.debugLog('Image file: ${imageFile?.path ?? "none provided"}');

      http.Response response;

      if (imageFile != null) {
        // Create multipart request for image upload
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(ApiConfig.masterCategoriesUrl),
        );

        // Add text fields
        request.fields['name'] = name;
        request.fields['module'] = module ?? 'Food';
        if (iconUrl != null && iconUrl.isNotEmpty) {
          request.fields['icon_url'] = iconUrl;
        }

        // Debug: Log all fields being sent
        ApiConfig.debugLog('Multipart fields: ${request.fields}');

        // Add image file
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );

        // Debug: Log file info
        ApiConfig.debugLog(
          'Multipart files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}',
        );
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
          Uri.parse(ApiConfig.masterCategoriesUrl),
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
          ApiConfig.debugLog(
            'Failed to add category - API returned success=false: ${data['message']}',
          );
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
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
      ApiConfig.debugLog('Request URL: ${ApiConfig.masterCategoriesUrl}');
      ApiConfig.debugLog('Category ID: $id');
      ApiConfig.debugLog('Category name: $name');
      ApiConfig.debugLog('Image file: ${imageFile?.path ?? 'null'}');

      http.Response response;

      if (imageFile != null) {
        // Create multipart request for image upload (use POST with method override for PHP compatibility)
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(ApiConfig.masterCategoriesUrl),
        );

        // Add text fields
        request.fields['_method'] = 'PUT'; // Method override for PHP
        request.fields['id'] = id.toString();
        request.fields['name'] = name;

        // Debug: Log all fields being sent
        ApiConfig.debugLog('Multipart fields: ${request.fields}');

        // Add image file
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );

        // Debug: Log file info
        ApiConfig.debugLog(
          'Multipart files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}',
        );
        ApiConfig.debugLog('Sending multipart request with image');
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Regular JSON request without image
        final requestBody = {'id': id, 'name': name};
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
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          ApiConfig.debugLog('Category updated successfully: ${data['data']}');
          return data['data'];
        } else {
          ApiConfig.debugLog(
            'Failed to update category - API returned success=false: ${data['message']}',
          );
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
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
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to delete food category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deleteFoodCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Sub-Category CRUD Methods

  // Get all sub-categories
  static Future<List<Map<String, dynamic>>> getSubCategories({
    String? masterCatId,
  }) async {
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
          ApiConfig.debugLog(
            'Successfully retrieved ${subCategories.length} sub-categories',
          );
          return subCategories;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
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
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
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
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
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
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to delete sub-category');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deleteSubCategory: $e');
      throw Exception('Error: $e');
    }
  }

  // Get master categories by module for sub-category dropdown
  static Future<List<Map<String, dynamic>>> getMasterCategoriesByModule({
    required String module,
  }) async {
    try {
      ApiConfig.debugLog('Starting getMasterCategoriesByModule request');
      // Add cache-busting parameter
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String url =
          '${ApiConfig.subCategoryUrl}?action=master_categories&module=$module&_t=$timestamp';
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
          ApiConfig.debugLog(
            'Successfully retrieved ${categories.length} master categories for $module',
          );
          ApiConfig.debugLog(
            'Categories received: ${categories.map((c) => c['name']).toList()}',
          );
          return categories;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to load master categories');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getMasterCategoriesByModule: $e');
      throw Exception('Error: $e');
    }
  }

  // Nutrition Master CRUD Methods

  // Get all nutrition items
  static Future<List<Map<String, dynamic>>> getNutritionItems() async {
    try {
      ApiConfig.debugLog('Starting getNutritionItems request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.nutritionMasterUrl}');

      final response = await http.get(
        Uri.parse(ApiConfig.nutritionMasterUrl),
        headers: {'Content-Type': 'application/json'},
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          final nutritionItems = List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog(
            'Successfully retrieved ${nutritionItems.length} nutrition items',
          );
          return nutritionItems;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to load nutrition items');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getNutritionItems: $e');
      throw Exception('Error: $e');
    }
  }

  // Add new nutrition item
  static Future<Map<String, dynamic>> addNutritionItem({
    required String name,
  }) async {
    try {
      ApiConfig.debugLog('Starting addNutritionItem request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.nutritionMasterUrl}');
      ApiConfig.debugLog('Nutrition name: $name');

      final requestBody = {'name': name};
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.post(
        Uri.parse(ApiConfig.nutritionMasterUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          ApiConfig.debugLog('Nutrition item added successfully');
          return data['data'];
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to add nutrition item');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in addNutritionItem: $e');
      throw Exception('Error: $e');
    }
  }

  // Update nutrition item
  static Future<Map<String, dynamic>> updateNutritionItem({
    required int id,
    required String name,
  }) async {
    try {
      ApiConfig.debugLog('Starting updateNutritionItem request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.nutritionMasterUrl}');
      ApiConfig.debugLog('Nutrition ID: $id');
      ApiConfig.debugLog('Nutrition name: $name');

      final requestBody = {'id': id, 'name': name};
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.put(
        Uri.parse(ApiConfig.nutritionMasterUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          ApiConfig.debugLog('Nutrition item updated successfully');
          return data;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to update nutrition item');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in updateNutritionItem: $e');
      throw Exception('Error: $e');
    }
  }

  // Delete nutrition item
  static Future<bool> deleteNutritionItem(int id) async {
    try {
      ApiConfig.debugLog('Starting deleteNutritionItem request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.nutritionMasterUrl}');
      ApiConfig.debugLog('Nutrition ID to delete: $id');

      final requestBody = {'id': id};
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.delete(
        Uri.parse(ApiConfig.nutritionMasterUrl),
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
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to delete nutrition item');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deleteNutritionItem: $e');
      throw Exception('Error: $e');
    }
  }

  // Allergen Master CRUD Methods

  // Get all allergen items
  static Future<List<Map<String, dynamic>>> getAllergenItems() async {
    try {
      ApiConfig.debugLog('Starting getAllergenItems request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.allergenMasterUrl}');

      final response = await http.get(
        Uri.parse(ApiConfig.allergenMasterUrl),
        headers: {'Content-Type': 'application/json'},
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          final allergenItems = List<Map<String, dynamic>>.from(data['data']);
          ApiConfig.debugLog(
            'Successfully retrieved ${allergenItems.length} allergen items',
          );
          return allergenItems;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to load allergen items');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in getAllergenItems: $e');
      throw Exception('Error: $e');
    }
  }

  // Add new allergen item
  static Future<Map<String, dynamic>> addAllergenItem({
    required String name,
  }) async {
    try {
      ApiConfig.debugLog('Starting addAllergenItem request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.allergenMasterUrl}');
      ApiConfig.debugLog('Allergen name: $name');

      final requestBody = {'name': name};
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.post(
        Uri.parse(ApiConfig.allergenMasterUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          ApiConfig.debugLog('Allergen item added successfully');
          return data['data'];
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to add allergen item');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in addAllergenItem: $e');
      throw Exception('Error: $e');
    }
  }

  // Update allergen item
  static Future<Map<String, dynamic>> updateAllergenItem({
    required int id,
    required String name,
  }) async {
    try {
      ApiConfig.debugLog('Starting updateAllergenItem request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.allergenMasterUrl}');
      ApiConfig.debugLog('Allergen ID: $id');
      ApiConfig.debugLog('Allergen name: $name');

      final requestBody = {'id': id, 'name': name};
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.put(
        Uri.parse(ApiConfig.allergenMasterUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      ApiConfig.debugLog('Response status code: ${response.statusCode}');
      ApiConfig.debugLog('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiConfig.debugLog('Decoded response data: $data');

        if (data['success']) {
          ApiConfig.debugLog('Allergen item updated successfully');
          return data;
        } else {
          ApiConfig.debugLog('API returned success=false: ${data['message']}');
          throw Exception(data['message']);
        }
      } else {
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to update allergen item');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in updateAllergenItem: $e');
      throw Exception('Error: $e');
    }
  }

  // Delete allergen item
  static Future<bool> deleteAllergenItem(int id) async {
    try {
      ApiConfig.debugLog('Starting deleteAllergenItem request');
      ApiConfig.debugLog('Request URL: ${ApiConfig.allergenMasterUrl}');
      ApiConfig.debugLog('Allergen ID to delete: $id');

      final requestBody = {'id': id};
      ApiConfig.debugLog('Request body: $requestBody');

      final response = await http.delete(
        Uri.parse(ApiConfig.allergenMasterUrl),
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
        ApiConfig.debugLog(
          'HTTP request failed with status: ${response.statusCode}',
        );
        throw Exception('Failed to delete allergen item');
      }
    } catch (e) {
      ApiConfig.debugLog('Exception in deleteAllergenItem: $e');
      throw Exception('Error: $e');
    }
  }
}
