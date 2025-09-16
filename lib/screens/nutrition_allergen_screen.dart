import 'package:flutter/material.dart';
import '../services/api_service.dart';

class NutritionAllergenScreen extends StatefulWidget {
  const NutritionAllergenScreen({super.key});

  @override
  State<NutritionAllergenScreen> createState() =>
      _NutritionAllergenScreenState();
}

class _NutritionAllergenScreenState extends State<NutritionAllergenScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> nutritionItems = [];
  List<Map<String, dynamic>> allergenItems = [];
  bool isLoading = true;
  bool isLoadingNutrition = false;
  bool isLoadingAllergen = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      await Future.wait([_loadNutritionItems(), _loadAllergenItems()]);
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

  Future<void> _loadNutritionItems() async {
    setState(() {
      isLoadingNutrition = true;
    });

    try {
      final items = await ApiService.getNutritionItems();
      setState(() {
        nutritionItems = items;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading nutrition items: $e')),
      );
    } finally {
      setState(() {
        isLoadingNutrition = false;
      });
    }
  }

  Future<void> _loadAllergenItems() async {
    setState(() {
      isLoadingAllergen = true;
    });

    try {
      final items = await ApiService.getAllergenItems();
      setState(() {
        allergenItems = items;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading allergen items: $e')),
      );
    } finally {
      setState(() {
        isLoadingAllergen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition & Allergen Ingredients'),
        backgroundColor: const Color(0xFF1E4A52),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [Tab(text: 'Nutrition'), Tab(text: 'Allergens')],
        ),
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                controller: _tabController,
                children: [_buildNutritionTab(), _buildAllergenTab()],
              ),
    );
  }

  Widget _buildNutritionTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showAddNutritionDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Nutrition'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E4A52),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child:
              isLoadingNutrition
                  ? const Center(child: CircularProgressIndicator())
                  : nutritionItems.isEmpty
                  ? const Center(
                    child: Text(
                      'No nutrition items found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                  : ListView.builder(
                    itemCount: nutritionItems.length,
                    itemBuilder: (context, index) {
                      final item = nutritionItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          title: Text(
                            item['name'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            'ID: ${item['nutrition_id']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _showEditNutritionDialog(item),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed:
                                    () => _showDeleteNutritionDialog(item),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }

  Widget _buildAllergenTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showAddAllergenDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Allergen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E4A52),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child:
              isLoadingAllergen
                  ? const Center(child: CircularProgressIndicator())
                  : allergenItems.isEmpty
                  ? const Center(
                    child: Text(
                      'No allergen items found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                  : ListView.builder(
                    itemCount: allergenItems.length,
                    itemBuilder: (context, index) {
                      final item = allergenItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          title: Text(
                            item['name'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            'ID: ${item['allergen_id']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _showEditAllergenDialog(item),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed:
                                    () => _showDeleteAllergenDialog(item),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }

  void _showAddNutritionDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Nutrition Item'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nutrition Name',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.trim().isNotEmpty) {
                    Navigator.of(context).pop();
                    await _addNutritionItem(nameController.text.trim());
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  void _showEditNutritionDialog(Map<String, dynamic> item) {
    final nameController = TextEditingController(text: item['name']);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Nutrition Item'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nutrition Name',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.trim().isNotEmpty) {
                    Navigator.of(context).pop();
                    await _updateNutritionItem(
                      item['nutrition_id'],
                      nameController.text.trim(),
                    );
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
    );
  }

  void _showDeleteNutritionDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Nutrition Item'),
            content: Text('Are you sure you want to delete "${item['name']}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _deleteNutritionItem(item['nutrition_id']);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  void _showAddAllergenDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Allergen Item'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Allergen Name',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.trim().isNotEmpty) {
                    Navigator.of(context).pop();
                    await _addAllergenItem(nameController.text.trim());
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  void _showEditAllergenDialog(Map<String, dynamic> item) {
    final nameController = TextEditingController(text: item['name']);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Allergen Item'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Allergen Name',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.trim().isNotEmpty) {
                    Navigator.of(context).pop();
                    await _updateAllergenItem(
                      item['allergen_id'],
                      nameController.text.trim(),
                    );
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
    );
  }

  void _showDeleteAllergenDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Allergen Item'),
            content: Text('Are you sure you want to delete "${item['name']}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _deleteAllergenItem(item['allergen_id']);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  Future<void> _addNutritionItem(String name) async {
    try {
      await ApiService.addNutritionItem(name: name);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nutrition item added successfully')),
      );
      await _loadNutritionItems();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding nutrition item: $e')),
      );
    }
  }

  Future<void> _updateNutritionItem(int id, String name) async {
    try {
      await ApiService.updateNutritionItem(id: id, name: name);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nutrition item updated successfully')),
      );
      await _loadNutritionItems();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating nutrition item: $e')),
      );
    }
  }

  Future<void> _deleteNutritionItem(int id) async {
    try {
      final success = await ApiService.deleteNutritionItem(id);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nutrition item deleted successfully')),
        );
        await _loadNutritionItems();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete nutrition item')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting nutrition item: $e')),
      );
    }
  }

  Future<void> _addAllergenItem(String name) async {
    try {
      await ApiService.addAllergenItem(name: name);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Allergen item added successfully')),
      );
      await _loadAllergenItems();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error adding allergen item: $e')));
    }
  }

  Future<void> _updateAllergenItem(int id, String name) async {
    try {
      await ApiService.updateAllergenItem(id: id, name: name);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Allergen item updated successfully')),
      );
      await _loadAllergenItems();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating allergen item: $e')),
      );
    }
  }

  Future<void> _deleteAllergenItem(int id) async {
    try {
      final success = await ApiService.deleteAllergenItem(id);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Allergen item deleted successfully')),
        );
        await _loadAllergenItems();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete allergen item')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting allergen item: $e')),
      );
    }
  }
}
