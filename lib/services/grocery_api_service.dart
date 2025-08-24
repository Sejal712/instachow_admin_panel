import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class GroceryApiService {
  // Get all grocery categories
  static Future<List<Map<String, dynamic>>> getGroceryCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.groceryCategoriesUrl),
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
          throw Exception(data['message'] ?? 'Failed to fetch grocery categories');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: Failed to fetch grocery categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Add new grocery category with image upload
  static Future<Map<String, dynamic>> addGroceryCategory({
    required String name,
    String? iconUrl,
    File? imageFile,
  }) async {
    try {
      http.Response response;

      if (imageFile != null) {
        var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.groceryCategoriesUrl));

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
          Uri.parse(ApiConfig.groceryCategoriesUrl),
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
        throw Exception('Failed to add grocery category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Update grocery category with image upload support
  static Future<Map<String, dynamic>> updateGroceryCategory({
    required int id,
    required String name,
    File? imageFile,
  }) async {
    try {
      http.Response response;

      if (imageFile != null) {
        var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.groceryCategoriesUrl));

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
          Uri.parse(ApiConfig.groceryCategoriesUrl),
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
        throw Exception('Failed to update grocery category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Delete grocery category
  static Future<bool> deleteGroceryCategory(int id) async {
    try {
      final requestBody = {'id': id};

      final response = await http.delete(
        Uri.parse(ApiConfig.groceryCategoriesUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'];
      } else {
        throw Exception('Failed to delete grocery category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
