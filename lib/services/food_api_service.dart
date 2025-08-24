import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class FoodApiService {
  // Get all food categories
  static Future<List<Map<String, dynamic>>> getFoodCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.foodCategoriesUrl),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
        },
      );

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
      throw Exception('Error: $e');
    }
  }

  // Add new food category with image upload
  static Future<Map<String, dynamic>> addFoodCategory({
    required String name,
    String? iconUrl,
    File? imageFile,
  }) async {
    try {
      http.Response response;

      if (imageFile != null) {
        var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.foodCategoriesUrl));

        request.fields['name'] = name;
        if (iconUrl != null && iconUrl.isNotEmpty) {
          request.fields['icon_url'] = iconUrl;
        }

        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        final requestBody = {
          'name': name,
          'icon_url': iconUrl ?? '',
        };

        response = await http.post(
          Uri.parse(ApiConfig.foodCategoriesUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );
      }

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
      http.Response response;

      if (imageFile != null) {
        var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.foodCategoriesUrl));

        request.fields['_method'] = 'PUT';
        request.fields['id'] = id.toString();
        request.fields['name'] = name;

        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        final requestBody = {
          'id': id,
          'name': name,
        };

        response = await http.put(
          Uri.parse(ApiConfig.foodCategoriesUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );
      }

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
      throw Exception('Error: $e');
    }
  }

  // Delete food category
  static Future<bool> deleteFoodCategory(int id) async {
    try {
      final requestBody = {'id': id};

      final response = await http.delete(
        Uri.parse(ApiConfig.foodCategoriesUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'];
      } else {
        throw Exception('Failed to delete food category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
