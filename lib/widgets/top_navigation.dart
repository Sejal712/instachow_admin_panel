import 'package:flutter/material.dart';
import 'modules_section.dart';

class TopNavigation extends StatelessWidget {
  final String selectedOption;
  final String selectedModule;
  final Function(String) onModuleChanged;

  const TopNavigation({
    super.key,
    required this.selectedOption,
    required this.selectedModule,
    required this.onModuleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 16),
          // Breadcrumb or current page indicator
          Text(
            selectedOption,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          // Top right icons
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.people, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.receipt_long, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.help_outline, color: Colors.grey),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              // Search bar
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search or...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Notification badge
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // User profile dropdown
              Row(
                children: [
                  const Text(
                    'En',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      _showModulesDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(_getModuleIcon(selectedModule), color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            selectedModule,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showModulesDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ModulesSection(
            selectedModule: selectedModule,
            onModuleSelected: (module) {
              onModuleChanged(module);
              Navigator.of(context).pop();
            },
          ),
        );
      },
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
        return Icons.shopping_cart;
    }
  }
}
