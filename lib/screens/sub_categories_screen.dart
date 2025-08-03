import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../config/api_config.dart';

class SubCategoriesScreen extends StatefulWidget {
  final String selectedModule;
  
  const SubCategoriesScreen({
    super.key,
    required this.selectedModule,
  });

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  int _selectedLanguageIndex = 0;
  final TextEditingController _subCategoryNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Map<String, dynamic>> _subCategories = [];
  List<Map<String, dynamic>> _masterCategories = [];
  bool _isLoading = false;
  bool _isAddingSubCategory = false;
  String? _selectedMasterCategoryId;
  String? _editingSubCategoryId;

  @override
  void initState() {
    super.initState();
    _loadMasterCategories();
    _loadSubCategories();
  }

  @override
  void didUpdateWidget(SubCategoriesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload master categories if the module has changed
    if (oldWidget.selectedModule != widget.selectedModule) {
      _selectedMasterCategoryId = null; // Clear selection when module changes
      _loadMasterCategories();
      _loadSubCategories();
    }
  }

  @override
  void dispose() {
    _subCategoryNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadMasterCategories() async {
    try {
      final categories = await ApiService.getMasterCategoriesByModule(module: widget.selectedModule);
      setState(() {
        _masterCategories = categories;
      });
    } catch (e) {
      ApiConfig.debugLog('Error loading master categories: $e');
    }
  }

  Future<void> _loadSubCategories() async {
    setState(() {
      _isLoading = true;
      _subCategories = []; // Clear existing data first
    });

    try {
      ApiConfig.debugLog('Loading sub-categories for module: ${widget.selectedModule}');
      
      // Get all sub-categories first
      final allSubCategories = await ApiService.getSubCategories();
      ApiConfig.debugLog('Retrieved ${allSubCategories.length} total sub-categories');
      
      // Get master categories for the current module
      final masterCategories = await ApiService.getFoodCategories(module: widget.selectedModule);
      ApiConfig.debugLog('Retrieved ${masterCategories.length} master categories for ${widget.selectedModule}');
      
      // Create a set of master category IDs for the current module for faster lookup
      final currentModuleMasterCatIds = masterCategories
          .map((masterCat) => masterCat['id'].toString())
          .toSet();
      
      ApiConfig.debugLog('Master category IDs for ${widget.selectedModule}: $currentModuleMasterCatIds');
      
      // Filter sub-categories to only show those belonging to master categories of the current module
      final filteredSubCategories = allSubCategories.where((subCategory) {
        String masterCatId = subCategory['master_cat_food_id'].toString();
        bool belongs = currentModuleMasterCatIds.contains(masterCatId);
        if (belongs) {
          ApiConfig.debugLog('Sub-category "${subCategory['name']}" belongs to ${widget.selectedModule} (master cat ID: $masterCatId)');
        }
        return belongs;
      }).toList();
      
      setState(() {
        _subCategories = filteredSubCategories;
        _isLoading = false;
      });
      
      ApiConfig.debugLog('Successfully filtered to ${filteredSubCategories.length} sub-categories for ${widget.selectedModule}');
    } catch (e) {
      setState(() {
        _isLoading = false;
        _subCategories = []; // Ensure empty list on error
      });
      ApiConfig.debugLog('Error loading sub-categories: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading sub-categories: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _addSubCategory() async {
    if (_subCategoryNameController.text.trim().isEmpty || _selectedMasterCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isAddingSubCategory = true;
    });

    try {
      await ApiService.addSubCategory(
        name: _subCategoryNameController.text.trim(),
        description: _descriptionController.text.trim(),
        masterCatId: _selectedMasterCategoryId!,
      );

      _subCategoryNameController.clear();
      _descriptionController.clear();
      _selectedMasterCategoryId = null;
      
      await _loadSubCategories();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sub-category added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding sub-category: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isAddingSubCategory = false;
      });
    }
  }

  Future<void> _updateSubCategory() async {
    if (_subCategoryNameController.text.trim().isEmpty || 
        _selectedMasterCategoryId == null || 
        _editingSubCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isAddingSubCategory = true;
    });

    try {
      await ApiService.updateSubCategory(
        id: _editingSubCategoryId!,
        name: _subCategoryNameController.text.trim(),
        description: _descriptionController.text.trim(),
        masterCatId: _selectedMasterCategoryId!,
      );

      _subCategoryNameController.clear();
      _descriptionController.clear();
      _selectedMasterCategoryId = null;
      _editingSubCategoryId = null;
      
      await _loadSubCategories();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sub-category updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating sub-category: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isAddingSubCategory = false;
      });
    }
  }

  Future<void> _deleteSubCategory(String id, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "$name"?'),
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
      ),
    );

    if (confirmed == true) {
      try {
        await ApiService.deleteSubCategory(id);
        await _loadSubCategories();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sub-category deleted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting sub-category: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _editSubCategory(Map<String, dynamic> subCategory) async {
    setState(() {
      _editingSubCategoryId = subCategory['id'].toString();
      _subCategoryNameController.text = subCategory['name'] ?? '';
      _descriptionController.text = subCategory['description'] ?? '';
      _selectedMasterCategoryId = null; // Reset first
    });

    try {
      // Load ONLY master categories for the current module (not all categories)
      ApiConfig.debugLog('Loading master categories for current module: ${widget.selectedModule}');
      
      final masterCategories = await ApiService.getFoodCategories(module: widget.selectedModule);
      
      // Remove duplicates and null values
      final uniqueMasterCategories = <String, Map<String, dynamic>>{};
      for (var category in masterCategories) {
        if (category['id'] != null && category['name'] != null) {
          String id = category['id'].toString();
          uniqueMasterCategories[id] = category;
        }
      }
      
      setState(() {
        _masterCategories = uniqueMasterCategories.values.toList();
      });

      // Set the selected master category
      String masterCatId = subCategory['master_cat_food_id'].toString();
      
      // Check if the master category exists in current module
      bool categoryExists = _masterCategories.any((cat) => cat['id'].toString() == masterCatId);
      
      setState(() {
        if (categoryExists) {
          _selectedMasterCategoryId = masterCatId;
          ApiConfig.debugLog('Edit mode: Set selected master category to $masterCatId');
        } else {
          _selectedMasterCategoryId = null;
          ApiConfig.debugLog('Edit mode: Master category $masterCatId not found in ${widget.selectedModule} module');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Warning: This sub-category belongs to a different module. Please select a ${widget.selectedModule} master category.'),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 4),
              ),
            );
          }
        }
      });
      
      ApiConfig.debugLog('Edit mode: Loaded ${_masterCategories.length} master categories for ${widget.selectedModule}');
    } catch (e) {
      ApiConfig.debugLog('Error loading master categories for edit: $e');
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

  void _cancelEdit() {
    setState(() {
      _editingSubCategoryId = null;
      _subCategoryNameController.clear();
      _descriptionController.clear();
      _selectedMasterCategoryId = null;
    });
    
    // Reload master categories for the current module
    _loadMasterCategories();
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return _masterCategories
      .where((category) => category['id'] != null && category['name'] != null)
      .map<DropdownMenuItem<String>>((category) {
        final id = category['id'].toString();
        final name = category['name'].toString();
        return DropdownMenuItem<String>(
          value: id,
          child: Text(name),
        );
      }).toSet().toList(); // Remove duplicates by converting to Set then back to List
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 32,
                  color: Colors.teal[600],
                ),
                const SizedBox(width: 12),
                Text(
                  'Sub Categories Management',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Manage sub-categories for ${widget.selectedModule}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            // Add/Edit Sub Category Form
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _editingSubCategoryId != null ? Icons.edit : Icons.add,
                        color: Colors.teal[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _editingSubCategoryId != null ? 'Edit Sub Category' : 'Add New Sub Category',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (_editingSubCategoryId != null) ...[
                        const Spacer(),
                        TextButton(
                          onPressed: _cancelEdit,
                          child: const Text('Cancel'),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Language Tabs
                  Row(
                    children: [
                      _buildLanguageTab('Default', 0),
                      _buildLanguageTab('English(EN)', 1),
                      _buildLanguageTab('Arabic - عربية(AR)', 2),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Form Fields
                  Row(
                    children: [
                      // Sub Category Name
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Name (Default) ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _subCategoryNameController,
                              decoration: InputDecoration(
                                hintText: 'New sub category',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.teal[600]!),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),

                      // Master Category Dropdown
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Main category ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedMasterCategoryId,
                              decoration: InputDecoration(
                                hintText: 'Select Main Category',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              items: _buildDropdownItems(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedMasterCategoryId = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a main category';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter description (optional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.teal[600]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          _subCategoryNameController.clear();
                          _descriptionController.clear();
                          _selectedMasterCategoryId = null;
                          _editingSubCategoryId = null;
                        },
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _isAddingSubCategory 
                          ? null 
                          : (_editingSubCategoryId != null ? _updateSubCategory : _addSubCategory),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isAddingSubCategory
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(_editingSubCategoryId != null ? 'Update' : 'Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Sub Categories List
            Container(
              height: 400, // Fixed height instead of Expanded
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal[600],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Sub Category List',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_subCategories.length}',
                            style: TextStyle(
                              color: Colors.teal[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // List Content
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                            ),
                          )
                        : _subCategories.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.category_outlined,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No sub-categories found for ${widget.selectedModule}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Add your first sub-category above',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: _subCategories.length,
                                itemBuilder: (context, index) {
                                  return _buildSubCategoryItem(_subCategories[index], index);
                                },
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTab(String title, int index) {
    final isSelected = _selectedLanguageIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguageIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal[600] : Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSubCategoryItem(Map<String, dynamic> subCategory, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Index
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Sub Category Info
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subCategory['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subCategory['description'] != null && subCategory['description'].toString().isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subCategory['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Master Category
            Expanded(
              flex: 2,
              child: Text(
                subCategory['master_category_name'] ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Status (Active by default)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Active',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _editSubCategory(subCategory),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.blue[600],
                    size: 20,
                  ),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () => _deleteSubCategory(
                    subCategory['id'].toString(),
                    subCategory['name'] ?? '',
                  ),
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red[600],
                    size: 20,
                  ),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
