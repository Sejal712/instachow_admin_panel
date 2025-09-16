import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final String selectedOption;
  final Function(String) onMenuItemSelected;

  const Sidebar({
    super.key,
    required this.selectedOption,
    required this.onMenuItemSelected,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isPosExpanded = true;
  bool isOrderManagementExpanded = true;
  bool isPromotionManagementExpanded = true;
  bool isProductManagementExpanded = true;
  bool isStoreManagementExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: const Color(0xFF1E4A52),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Color(0xFF1E4A52),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'GamMart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Search Menu
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF2A5A62),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Menu...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white70),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Menu Items
          Expanded(
            child: ListView(
              children: [
                // POS SECTION
                _buildSectionHeader('POS SECTION'),
                _buildExpandableSection(
                  'POS SECTION',
                  isPosExpanded,
                  (value) => setState(() => isPosExpanded = value),
                  [
                    _buildMenuItem(Icons.dashboard, 'Dashboard'),
                    _buildMenuItem(Icons.point_of_sale, 'New Sale'),
                  ],
                ),

                // ORDER MANAGEMENT
                _buildSectionHeader('ORDER MANAGEMENT'),
                _buildExpandableSection(
                  'ORDER MANAGEMENT',
                  isOrderManagementExpanded,
                  (value) => setState(() => isOrderManagementExpanded = value),
                  [
                    _buildMenuItem(Icons.shopping_bag, 'Orders'),
                    _buildMenuItem(Icons.assignment_return, 'Order Refunds'),
                    _buildMenuItem(Icons.flash_on, 'Flash Sales'),
                  ],
                ),

                // PROMOTION MANAGEMENT
                _buildSectionHeader('PROMOTION MANAGEMENT'),
                _buildExpandableSection(
                  'PROMOTION MANAGEMENT',
                  isPromotionManagementExpanded,
                  (value) =>
                      setState(() => isPromotionManagementExpanded = value),
                  [
                    _buildMenuItem(Icons.campaign, 'Campaigns'),
                    _buildMenuItem(Icons.flag, 'Banners'),
                    _buildMenuItem(Icons.outlined_flag, 'Other Banners'),
                    _buildMenuItem(Icons.local_offer, 'Coupons'),
                    _buildMenuItem(Icons.notifications, 'Push Notification'),
                  ],
                ),

                // PRODUCT MANAGEMENT
                _buildSectionHeader('PRODUCT MANAGEMENT'),
                _buildExpandableSection(
                  'PRODUCT MANAGEMENT',
                  isProductManagementExpanded,
                  (value) =>
                      setState(() => isProductManagementExpanded = value),
                  [
                    _buildMenuItem(Icons.category, 'Categories'),
                    _buildMenuItem(
                      Icons.subdirectory_arrow_right,
                      'Sub Category',
                    ),
                    _buildMenuItem(Icons.file_upload, 'Bulk Import'),
                    _buildMenuItem(Icons.file_download, 'Bulk Export'),
                    _buildMenuItem(Icons.tune, 'Attributes'),
                    _buildMenuItem(Icons.straighten, 'Units'),
                    _buildMenuItem(Icons.settings, 'Product Setup'),
                    _buildMenuItem(
                      Icons.restaurant_menu,
                      'Add Nutrition & Allergen Ingredients',
                    ),
                  ],
                ),

                // STORE MANAGEMENT
                _buildSectionHeader('STORE MANAGEMENT'),
                _buildExpandableSection(
                  'STORE MANAGEMENT',
                  isStoreManagementExpanded,
                  (value) => setState(() => isStoreManagementExpanded = value),
                  [
                    _buildMenuItem(Icons.store, 'New Stores'),
                    _buildMenuItem(Icons.add_business, 'Add Store'),
                    _buildMenuItem(Icons.list, 'Stores List'),
                    _buildMenuItem(Icons.recommend, 'Recommended Store'),
                  ],
                ),
              ],
            ),
          ),
          // User Profile at bottom
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 16,
                  child: const Text(
                    'JD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Jhon Doe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'jhondoe@gammin.com',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildExpandableSection(
    String title,
    bool isExpanded,
    Function(bool) onExpansionChanged,
    List<Widget> children,
  ) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.transparent, fontSize: 0),
      ),
      initiallyExpanded: isExpanded,
      onExpansionChanged: onExpansionChanged,
      children: children,
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      iconColor: Colors.transparent,
      collapsedIconColor: Colors.transparent,
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    bool isSelected = widget.selectedOption == title;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2A5A62) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white70,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        onTap: () {
          widget.onMenuItemSelected(title);
        },
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
