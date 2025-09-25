import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../services/api_service.dart';

class PharmacyCategoriesScreen extends StatefulWidget {
  const PharmacyCategoriesScreen({super.key});

  @override
  State<PharmacyCategoriesScreen> createState() =>
      _PharmacyCategoriesScreenState();
}

class _PharmacyCategoriesScreenState extends State<PharmacyCategoriesScreen> {
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;
  bool isAdding = false;

  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;
  String? _selectedImagePath;

  // For form editing
  bool isEditing = false;
  int? editingCategoryId;
  String? currentImageUrl;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    setState(() {
      isLoading = true;
    });

    try {
      final items = await ApiService.getPharmacyCategories();
      setState(() {
        categories = items;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading pharmacy categories: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedImage = File(result.files.first.path!);
          _selectedImagePath = result.files.first.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Future<void> _addCategory() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter category name')),
      );
      return;
    }

    setState(() {
      isAdding = true;
    });

    try {
      if (isEditing && editingCategoryId != null) {
        // Update existing category
        await ApiService.updatePharmacyCategory(
          id: editingCategoryId!,
          name: _nameController.text.trim(),
          imageFile: _selectedImage,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pharmacy category updated successfully'),
          ),
        );
      } else {
        // Add new category
        await ApiService.addPharmacyCategory(
          name: _nameController.text.trim(),
          imageFile: _selectedImage,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pharmacy category added successfully')),
        );
      }

      // Reset form
      _cancelEditing();
      await _loadCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error ${isEditing ? 'updating' : 'adding'} pharmacy category: $e',
          ),
        ),
      );
    } finally {
      setState(() {
        isAdding = false;
      });
    }
  }

  void _startEditing(Map<String, dynamic> category) {
    setState(() {
      isEditing = true;
      editingCategoryId = category['maste_cat_food_id'];
      _nameController.text = category['name'] ?? '';
      currentImageUrl = category['icon_url'];
      _selectedImage = null;
      _selectedImagePath = null;
    });
  }

  void _cancelEditing() {
    setState(() {
      isEditing = false;
      editingCategoryId = null;
      _nameController.clear();
      currentImageUrl = null;
      _selectedImage = null;
      _selectedImagePath = null;
    });
  }

  Future<void> _updateCategory(Map<String, dynamic> category) async {
    _startEditing(category);
  }

  Future<void> _deleteCategory(Map<String, dynamic> category) async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Pharmacy Category'),
            content: Text(
              'Are you sure you want to delete "${category['name']}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();

                  try {
                    final success = await ApiService.deletePharmacyCategory(
                      category['maste_cat_food_id'],
                    );
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Pharmacy category deleted successfully',
                          ),
                        ),
                      );
                      await _loadCategories();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to delete pharmacy category'),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error deleting pharmacy category: $e'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(
                  Icons.local_pharmacy,
                  size: 32,
                  color: Color(0xFF1E4A52),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Pharmacy Categories',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E4A52),
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _loadCategories(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E4A52),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Add Category Form
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing
                          ? 'Edit Pharmacy Category'
                          : 'Add New Pharmacy Category',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E4A52),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Category Name *',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., Prescriptions, OTC Medicine',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[50],
                              ),
                              child:
                                  _selectedImage != null
                                      ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          _selectedImage!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      )
                                      : const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.cloud_upload,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Upload Image',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '(Ratio 1:1)',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: isAdding ? null : _addCategory,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E4A52),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              child:
                                  isAdding
                                      ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                      : Text(
                                        isEditing
                                            ? 'Update Category'
                                            : 'Add Category',
                                      ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                _cancelEditing();
                              },
                              child: Text(isEditing ? 'Cancel Edit' : 'Reset'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Categories List
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Pharmacy Categories List',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E4A52),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E4A52),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${categories.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child:
                            isLoading
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                : categories.isEmpty
                                ? const Center(
                                  child: Text(
                                    'No pharmacy categories found',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                                : ListView.builder(
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final category = categories[index];
                                    return Card(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: const Color(
                                            0xFF1E4A52,
                                          ),
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          category['name'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ID: ${category['maste_cat_food_id']}',
                                            ),
                                            Text(
                                              'Module: ${category['module'] ?? 'Pharmacy'}',
                                            ),
                                            if (category['icon_url'] != null)
                                              Text(
                                                'Icon: ${category['icon_url']}',
                                              ),
                                          ],
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onPressed:
                                                  () =>
                                                      _updateCategory(category),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed:
                                                  () =>
                                                      _deleteCategory(category),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
