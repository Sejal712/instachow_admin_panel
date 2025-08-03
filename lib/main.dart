import 'package:flutter/material.dart';
import 'screens/admin_panel.dart';

void main() {
  runApp(const GamMartApp());
}

class GamMartApp extends StatelessWidget {
  const GamMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamMart Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AdminPanel(),
      debugShowCheckedModeBanner: false,
    );
  }
}
