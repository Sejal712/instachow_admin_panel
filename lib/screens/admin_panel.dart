import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/top_navigation.dart';
import '../widgets/main_content.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  String selectedOption = 'Dashboard';
  String selectedModule = 'Grocery';

  void onMenuItemSelected(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  void onModuleChanged(String module) {
    setState(() {
      selectedModule = module;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Sidebar(
            selectedOption: selectedOption,
            onMenuItemSelected: onMenuItemSelected,
          ),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Navigation Bar
                TopNavigation(
                  selectedOption: selectedOption,
                  selectedModule: selectedModule,
                  onModuleChanged: onModuleChanged,
                ),
                // Main Content
                Expanded(
                  child: MainContent(
                    selectedOption: selectedOption,
                    selectedModule: selectedModule,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
