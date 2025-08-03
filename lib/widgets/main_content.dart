import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/sub_categories_screen.dart';

class MainContent extends StatelessWidget {
  final String selectedOption;
  final String selectedModule;

  const MainContent({
    super.key,
    required this.selectedOption,
    required this.selectedModule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: _buildContentForOption(selectedOption),
    );
  }

  Widget _buildContentForOption(String option) {
    switch (option) {
      case 'Categories':
        return CategoriesScreen(selectedModule: selectedModule);
      case 'Sub Category':
        return SubCategoriesScreen(selectedModule: selectedModule);
      default:
        return _buildDefaultScreen(option);
    }
  }

  Widget _buildDefaultScreen(String option) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForOption(option),
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to $option',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Content for $option will be displayed here.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForOption(String option) {
    switch (option) {
      case 'Dashboard':
        return Icons.dashboard;
      case 'New Sale':
        return Icons.point_of_sale;
      case 'Orders':
        return Icons.shopping_bag;
      case 'Order Refunds':
        return Icons.assignment_return;
      case 'Flash Sales':
        return Icons.flash_on;
      case 'Campaigns':
        return Icons.campaign;
      case 'Banners':
        return Icons.flag;
      case 'Other Banners':
        return Icons.outlined_flag;
      case 'Coupons':
        return Icons.local_offer;
      case 'Push Notification':
        return Icons.notifications;
      case 'Categories':
        return Icons.category;
      case 'Sub Category':
        return Icons.subdirectory_arrow_right;
      case 'Bulk Import':
        return Icons.file_upload;
      case 'Bulk Export':
        return Icons.file_download;
      case 'Attributes':
        return Icons.tune;
      case 'Units':
        return Icons.straighten;
      case 'Product Setup':
        return Icons.settings;
      case 'New Stores':
        return Icons.store;
      case 'Add Store':
        return Icons.add_business;
      case 'Stores List':
        return Icons.list;
      case 'Recommended Store':
        return Icons.recommend;
      default:
        return Icons.dashboard;
    }
  }
}
