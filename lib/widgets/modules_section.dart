import 'package:flutter/material.dart';

class ModulesSection extends StatefulWidget {
  final String selectedModule;
  final Function(String) onModuleSelected;

  const ModulesSection({
    super.key,
    required this.selectedModule,
    required this.onModuleSelected,
  });

  @override
  State<ModulesSection> createState() => _ModulesSectionState();
}

class _ModulesSectionState extends State<ModulesSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Modules Section',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select Module & Monitor\nyour business module wise',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          
          // Module grid
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              _buildModuleCard(
                icon: Icons.shopping_cart,
                title: 'Grocery',
                color: const Color(0xFF2D7D7D),
                isSelected: widget.selectedModule == 'Grocery',
              ),
              _buildModuleCard(
                icon: Icons.local_pharmacy,
                title: 'Pharmacy',
                color: const Color(0xFF4CAF50),
                isSelected: widget.selectedModule == 'Pharmacy',
              ),
              _buildModuleCard(
                icon: Icons.shopping_bag,
                title: 'Shop',
                color: const Color(0xFF2196F3),
                isSelected: widget.selectedModule == 'Shop',
              ),
              _buildModuleCard(
                icon: Icons.restaurant,
                title: 'Food',
                color: const Color(0xFFFF9800),
                isSelected: widget.selectedModule == 'Food',
              ),
              _buildModuleCard(
                icon: Icons.local_shipping,
                title: 'Parcel',
                color: const Color(0xFF9C27B0),
                isSelected: widget.selectedModule == 'Parcel',
              ),
              _buildModuleCard(
                icon: Icons.car_rental,
                title: 'Rental',
                color: const Color(0xFF607D8B),
                isSelected: widget.selectedModule == 'Rental',
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Add new module button
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Handle add new module
                },
                borderRadius: BorderRadius.circular(8),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Bottom section with dropdown and button
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: DropdownButton<String>(
                    value: 'Select',
                    isExpanded: true,
                    underline: Container(),
                    items: ['Select', 'Option 1', 'Option 2']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D7D7D),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard({
    required IconData icon,
    required String title,
    required Color color,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? color : Colors.grey[200]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.onModuleSelected(title);
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 28,
                  color: isSelected ? Colors.white : color,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
