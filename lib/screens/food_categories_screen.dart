import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/food_api_service.dart';
import '../config/api_config.dart';
import 'food_category_edit_screen.dart';

class FoodCategoriesScreen extends StatefulWidget {
  const FoodCategoriesScreen({super.key});

  @override
  State<FoodCategoriesScreen> createState() => _FoodCategoriesScreenState();
}

class _FoodCategoriesScreenState extends State<FoodCategoriesScreen> {
  int _selectedLanguageIndex = 0;
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _iconUrlController = TextEditingController();
  List<Map<String, dynamic>> _foodCategories = [];
  bool _isLoading = false;
  bool _isAddingCategory = false;
  File? _selectedImage;
  String? _selectedImageName;

  @override
  void initState() {
    super.initState();
    _loadFoodCategories();
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _iconUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedImage = File(result.files.single.path!);
          _selectedImageName = result.files.single.name;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _selectedImageName = null;
    });
  }

  Future<void> _loadFoodCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final categories = await FoodApiService.getFoodCategories();
      setState(() {
        _foodCategories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading categories: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _addFoodCategory() async {
    if (_categoryNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter category name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image for the category'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isAddingCategory = true;
    });

    try {
      await FoodApiService.addFoodCategory(
        name: _categoryNameController.text.trim(),
        iconUrl: _iconUrlController.text.trim(),
        imageFile: _selectedImage,
      );
      
      _categoryNameController.clear();
      _iconUrlController.clear();
      _removeImage();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Food category added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      await _loadFoodCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding category: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isAddingCategory = false;
      });
    }
  }

  Future<void> _showDeleteConfirmation(Map<String, dynamic> category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: Text('Are you sure you want to delete "${category['name']}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _deleteCategory(category['id']);
    }
  }

  Future<void> _deleteCategory(int categoryId) async {
    try {
      final success = await FoodApiService.deleteFoodCategory(categoryId);
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category deleted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        await _loadFoodCategories();
      } else {
        throw Exception('Failed to delete category');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting category: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.restaurant,
                size: 24,
                color: Colors.orange[600],
              ),
              const SizedBox(width: 12),
              const Text(
                'Food Categories Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Food Module',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange[700],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Language tabs
          Row(
            children: [
              _buildLanguageTab('Default', true),
              _buildLanguageTab('English(EN)', false),
              _buildLanguageTab('Arabic - العربية(AR)', false),
            ],
          ),
          const SizedBox(height: 32),
          
          // Form section
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Form
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name field
                      const Text(
                        'Name (Default) *',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _categoryNameController,
                          decoration: const InputDecoration(
                            hintText: 'New food category',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Action buttons
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              _categoryNameController.clear();
                              _iconUrlController.clear();
                              _removeImage();
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              side: BorderSide(color: Colors.grey[400]!),
                            ),
                            child: const Text(
                              'Reset',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: _isAddingCategory ? null : _addFoodCategory,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[600],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: _isAddingCategory
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Add',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                
                // Right side - Image upload
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Image *',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Ratio 1:1',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedImage != null ? Colors.green : Colors.grey[300]!,
                              style: BorderStyle.solid,
                              width: _selectedImage != null ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _selectedImage != null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                        _selectedImage!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: _removeImage,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      left: 8,
                                      right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          _selectedImageName ?? 'Selected Image',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 48,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Upload Image *',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Required',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey[300]!),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Choose File',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Category List section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Food Categories List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_foodCategories.length}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Table
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  // Table header
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Sl',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Id',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Featured',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Priority',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Action',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Table rows
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                            ),
                          )
                        : _foodCategories.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.restaurant_outlined,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No food categories found',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Add your first food category above',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: _foodCategories.length,
                                itemBuilder: (context, index) {
                                  final category = _foodCategories[index];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey[200]!,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text('${index + 1}'),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text('${category['id']}'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text('${category['name']}'),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Switch(
                                            value: true, // Default active status
                                            onChanged: (value) {},
                                            activeColor: Colors.orange[600],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Switch(
                                            value: false, // Default not featured
                                            onChanged: (value) {},
                                            activeColor: Colors.orange[600],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: DropdownButton<String>(
                                            value: 'Normal',
                                            items: ['Normal', 'High', 'Low']
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {},
                                            underline: Container(),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 18,
                                                  color: Colors.blue,
                                                ),
                                                onPressed: () async {
                                                  final result = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => FoodCategoryEditScreen(
                                                        category: category,
                                                      ),
                                                    ),
                                                  );
                                                  
                                                  if (result == true) {
                                                    await _loadFoodCategories();
                                                  }
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 18,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () => _showDeleteConfirmation(category),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTab(String title, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.orange[600] : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isActive ? Colors.orange[600]! : Colors.grey[300]!,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
