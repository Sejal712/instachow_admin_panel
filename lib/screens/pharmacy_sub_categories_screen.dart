import 'package:flutter/material.dart';
import 'package:instachow_admin_panel/services/api_service.dart';

class PharmacySubCategoriesScreen extends StatefulWidget {
  const PharmacySubCategoriesScreen({super.key});

  @override
  State<PharmacySubCategoriesScreen> createState() =>
      _PharmacySubCategoriesScreenState();
}

class _PharmacySubCategoriesScreenState
    extends State<PharmacySubCategoriesScreen> {
  List<Map<String, dynamic>> subCategories = [];
  List<Map<String, dynamic>> mainCategories = [];
  bool isLoading = true;
  bool isAdding = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // For form editing
  bool isEditing = false;
  int? editingSubCategoryId;
  int? selectedMainCategoryId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final futures = await Future.wait([
        ApiService.getPharmacySubCategories(),
        ApiService.getPharmacyMainCategories(),
      ]);

      setState(() {
        subCategories = futures[0];
        mainCategories = futures[1];
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading data: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _startEditing(Map<String, dynamic> subCategory) {
    setState(() {
      isEditing = true;
      editingSubCategoryId = subCategory['categories_id'];
      _nameController.text = subCategory['name'] ?? '';
      _descriptionController.text = subCategory['description'] ?? '';
      selectedMainCategoryId = subCategory['master_cat_food_id'];
    });
  }

  void _cancelEditing() {
    setState(() {
      isEditing = false;
      editingSubCategoryId = null;
      _nameController.clear();
      _descriptionController.clear();
      selectedMainCategoryId = null;
    });
  }

  Future<void> _addSubCategory() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter sub-category name')),
      );
      return;
    }

    if (selectedMainCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a main category')),
      );
      return;
    }

    setState(() {
      isAdding = true;
    });

    try {
      if (isEditing && editingSubCategoryId != null) {
        // Update existing sub-category
        await ApiService.updatePharmacySubCategory(
          id: editingSubCategoryId!,
          name: _nameController.text.trim(),
          description:
              _descriptionController.text.trim().isNotEmpty
                  ? _descriptionController.text.trim()
                  : null,
          masterCategoryId: selectedMainCategoryId!,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pharmacy sub-category updated successfully'),
          ),
        );
      } else {
        // Add new sub-category
        await ApiService.addPharmacySubCategory(
          name: _nameController.text.trim(),
          description:
              _descriptionController.text.trim().isNotEmpty
                  ? _descriptionController.text.trim()
                  : null,
          masterCategoryId: selectedMainCategoryId!,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pharmacy sub-category added successfully'),
          ),
        );
      }

      // Reset form
      _cancelEditing();
      await _loadData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error ${isEditing ? 'updating' : 'adding'} pharmacy sub-category: $e',
          ),
        ),
      );
    } finally {
      setState(() {
        isAdding = false;
      });
    }
  }

  Future<void> _updateSubCategory(Map<String, dynamic> subCategory) async {
    _startEditing(subCategory);
  }

  Future<void> _deleteSubCategory(Map<String, dynamic> subCategory) async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Pharmacy Sub-Category'),
            content: Text(
              'Are you sure you want to delete "${subCategory['name']}"?',
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
                    final success = await ApiService.deletePharmacySubCategory(
                      subCategory['categories_id'],
                    );
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Pharmacy sub-category deleted successfully',
                          ),
                        ),
                      );
                      await _loadData();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Failed to delete pharmacy sub-category',
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error deleting pharmacy sub-category: $e',
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add New Sub-Category Form
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing
                          ? 'Edit Pharmacy Sub-Category'
                          : 'Add New Pharmacy Sub-Category',
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
                        labelText: 'Sub-Category Name *',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., Prescription Medicines, OTC Products',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description (Optional)',
                        border: OutlineInputBorder(),
                        hintText: 'Brief description of the sub-category',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: selectedMainCategoryId,
                      decoration: const InputDecoration(
                        labelText: 'Main Category *',
                        border: OutlineInputBorder(),
                        hintText: 'Select Main Category',
                      ),
                      items:
                          mainCategories.map((category) {
                            return DropdownMenuItem<int>(
                              value: category['maste_cat_food_id'],
                              child: Text(category['name'] ?? ''),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMainCategoryId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isAdding ? null : _addSubCategory,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E4A52),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child:
                                isAdding
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : Text(
                                      isEditing
                                          ? 'Update Sub-Category'
                                          : 'Add Sub-Category',
                                    ),
                          ),
                        ),
                        const SizedBox(width: 16),
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
              ),
            ),
            const SizedBox(height: 24),
            // Sub-Categories List
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pharmacy Sub-Categories List',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E4A52),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E4A52),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${subCategories.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : subCategories.isEmpty
                        ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No sub-categories found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Add your first pharmacy sub-category above',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: subCategories.length,
                          itemBuilder: (context, index) {
                            final subCategory = subCategories[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xFF1E4A52),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  subCategory['name'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (subCategory['description'] != null &&
                                        subCategory['description'].isNotEmpty)
                                      Text(
                                        subCategory['description'],
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Main Category: ${subCategory['main_category_name'] ?? 'Unknown'}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'ID: ${subCategory['categories_id']}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
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
                                          () => _updateSubCategory(subCategory),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed:
                                          () => _deleteSubCategory(subCategory),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
