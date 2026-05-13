import 'package:flutter/material.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';
import 'package:medicuraapp/features/home/presentation/emergency.dart';
import 'package:medicuraapp/features/home/presentation/home_page.dart';
import 'package:medicuraapp/features/home/presentation/insights_page.dart';
import 'package:medicuraapp/features/home/presentation/emergency.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // The pages that the navbar will switch between
  final List<Widget> _pages = [
    const HomePage(),
    const HealthInsightsPage(),
    const EmergencyPage(),
    const Center(child: Text("Profile Page Coming Soon")), // Placeholder for 4th icon
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // IndexedStack keeps pages in memory so they don't reload when switching tabs
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildCustomNavBar(),
    );
  }

  // --- THE CUSTOM GRADIENT NAVBAR ---
  Widget _buildCustomNavBar() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E93B9), Color(0xFF4FD1C5)], // Matches your image gradient
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        // Optional: Add rounded corners if you want it to "float" slightly
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.home_filled, index: 0),
          _buildNavItem(icon: Icons.insights, index: 1),
          _buildNavItem(icon: Icons.medical_services_outlined, index: 2), // Medical phone alt
          _buildNavItem(icon: Icons.person, index: 3),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(isSelected ? 1.0 : 0.7), // Dim unselected icons
              size: 28,
            ),
            const SizedBox(height: 4),
            // The Active Dot Indicator
            if (isSelected)
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 6), // Keeps spacing consistent when dot is hidden
          ],
        ),
      ),
    );
  }
}