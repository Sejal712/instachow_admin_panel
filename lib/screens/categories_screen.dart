import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/api_service.dart';
import '../config/api_config.dart';
import 'category_edit_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final String selectedModule;
  
  const CategoriesScreen({
    super.key,
    required this.selectedModule,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
  void didUpdateWidget(CategoriesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload categories if the module has changed
    if (oldWidget.selectedModule != widget.selectedModule) {
      ApiConfig.debugLog('Module changed from ${oldWidget.selectedModule} to ${widget.selectedModule}, reloading categories...');
      
      // Force clear the state first
      setState(() {
        _foodCategories = [];
        _isLoading = true;
      });
      
      // Add a small delay to ensure state is cleared
      Future.delayed(Duration(milliseconds: 100), () {
        _loadFoodCategories();
      });
    }
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
      _foodCategories = []; // Clear existing data first
    });

    try {
      ApiConfig.debugLog('Loading categories for module: ${widget.selectedModule}');
      final categories = await ApiService.getFoodCategories(module: widget.selectedModule);
      
      setState(() {
        _foodCategories = categories;
        _isLoading = false;
      });
      
      ApiConfig.debugLog('Successfully retrieved ${categories.length} categories for ${widget.selectedModule}');
      
      // Debug: Log each category
      for (var category in categories) {
        ApiConfig.debugLog('Category: ${category['name']} (module: ${category['module']})');
      }
      
    } catch (e) {
      setState(() {
        _isLoading = false;
        _foodCategories = []; // Ensure empty list on error
      });
      ApiConfig.debugLog('Error loading categories: $e');
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
    // Validate category name
    if (_categoryNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter category name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate image upload (mandatory)
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
      await ApiService.addFoodCategory(
        name: _categoryNameController.text.trim(),
        iconUrl: _iconUrlController.text.trim(),
        imageFile: _selectedImage,
        module: widget.selectedModule,
      );
      
      // Clear form after successful addition
      _categoryNameController.clear();
      _iconUrlController.clear();
      _removeImage();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Reload categories to show updated list
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
      final success = await ApiService.deleteFoodCategory(categoryId);
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category deleted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Reload categories to reflect the deletion
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
      key: ValueKey('categories_${widget.selectedModule}'), // Force rebuild when module changes
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            // Header with icon and title
            Row(
              children: [
              Icon(
                _getModuleIcon(widget.selectedModule),
                size: 24,
                color: _getModuleColor(widget.selectedModule),
              ),
              const SizedBox(width: 12),
              Text(
                'Add New ${widget.selectedModule} Category',
                style: const TextStyle(
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
                  color: _getModuleColor(widget.selectedModule).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Module: ${widget.selectedModule}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _getModuleColor(widget.selectedModule),
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
                            hintText: 'New category',
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
                              backgroundColor: const Color(0xFF2D7D7D),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
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
                    'Category List',
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_getModuleCategories(widget.selectedModule).length}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search categories',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        suffixIcon: Icon(Icons.search, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.file_download, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Export',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
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
                  // Table rows - Dynamic based on module
                  Expanded(
                    child: ListView.builder(
                      itemCount: _getModuleCategories(widget.selectedModule).length,
                      itemBuilder: (context, index) {
                        final category = _getModuleCategories(widget.selectedModule)[index];
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
                                  value: category['status'],
                                  onChanged: (value) {},
                                  activeColor: _getModuleColor(widget.selectedModule),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Switch(
                                  value: category['featured'],
                                  onChanged: (value) {},
                                  activeColor: _getModuleColor(widget.selectedModule),
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
                                            builder: (context) => CategoryEditScreen(
                                              category: category,
                                            ),
                                          ),
                                        );
                                        
                                        // Reload categories if update was successful
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
        color: isActive ? const Color(0xFF2D7D7D) : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isActive ? const Color(0xFF2D7D7D) : Colors.grey[300]!,
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

  IconData _getModuleIcon(String module) {
    switch (module) {
      case 'Grocery':
        return Icons.shopping_cart;
      case 'Pharmacy':
        return Icons.local_pharmacy;
      case 'Shop':
        return Icons.shopping_bag;
      case 'Food':
        return Icons.restaurant;
      case 'Parcel':
        return Icons.local_shipping;
      case 'Rental':
        return Icons.car_rental;
      default:
        return Icons.category;
    }
  }

  Color _getModuleColor(String module) {
    switch (module) {
      case 'Grocery':
        return const Color(0xFF2D7D7D);
      case 'Pharmacy':
        return const Color(0xFF4CAF50);
      case 'Shop':
        return const Color(0xFF2196F3);
      case 'Food':
        return const Color(0xFFFF9800);
      case 'Parcel':
        return const Color(0xFF9C27B0);
      case 'Rental':
        return const Color(0xFF607D8B);
      default:
        return const Color(0xFF2D7D7D);
    }
  }

  List<Map<String, dynamic>> _getModuleCategories(String module) {
    switch (module) {
      case 'Grocery':
        return _foodCategories.map((category) => {
          'id': category['id'],
          'name': category['name'],
          'icon_url': category['icon_url'],
          'created_at': category['created_at'],
          'status': true, // Default active status
          'featured': false, // Default not featured
          'priority': 1, // Default priority
        }).toList();
      case 'Pharmacy':
        return [
          {'id': 201, 'name': 'Medicines', 'status': true, 'featured': true},
          {'id': 202, 'name': 'Health Care', 'status': true, 'featured': false},
          {'id': 203, 'name': 'Personal Care', 'status': true, 'featured': false},
        ];
      case 'Shop':
        return [
          {'id': 301, 'name': 'Electronics', 'status': true, 'featured': true},
          {'id': 302, 'name': 'Clothing', 'status': true, 'featured': false},
          {'id': 303, 'name': 'Accessories', 'status': true, 'featured': false},
        ];
      case 'Food':
        return _foodCategories.map((category) => {
          'id': category['id'],
          'name': category['name'],
          'icon_url': category['icon_url'],
          'created_at': category['created_at'],
          'status': true, // Default active status
          'featured': false, // Default not featured
          'priority': 1, // Default priority
        }).toList();
      case 'Parcel':
        return [
          {'id': 501, 'name': 'Documents', 'status': true, 'featured': false},
          {'id': 502, 'name': 'Packages', 'status': true, 'featured': true},
          {'id': 503, 'name': 'Express', 'status': true, 'featured': false},
        ];
      case 'Rental':
        return [
          {'id': 601, 'name': 'Cars', 'status': true, 'featured': true},
          {'id': 602, 'name': 'Bikes', 'status': true, 'featured': false},
          {'id': 603, 'name': 'Equipment', 'status': true, 'featured': false},
        ];
      default:
        return [
          {'id': 129, 'name': 'Default Category', 'status': true, 'featured': false},
        ];
    }
  }
}
