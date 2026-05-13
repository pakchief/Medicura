import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. TOP AVATAR SECTION
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatarimage.jpg'), // Your 3D Doctor Avatar
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              // App Bar Overlays
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: const Icon(Icons.menu, color: Color(0xFF4DD0E1)), onPressed: () {}),
                      Image.asset('assets/images/Medicuratext.png', height: 40),
                      IconButton(icon: const Icon(Icons.notifications, color: Color(0xFF4DD0E1)), onPressed: () {}),
                    ],
                  ),
                ),
              ),
              // Greeting Box
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () => context.push('/ai_chat'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [const Color(0xFF2698C2).withOpacity(0.8), const Color(0xFF57D0EB).withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Hello!", // Dynamically link to profile name if possible
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("How can I help you?",
                              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // 2. QUICK SERVICES GRID
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.8,
                children: [
                  _buildServiceCard(context, "Upload Report", Icons.add_circle_outline, '/home'),
                  _buildServiceCard(context, "Medicine Interaction", Icons.medication_outlined, '/home'),
                  _buildServiceCard(context, "Emergency Assistance", Icons.emergency_outlined, '/emergency'),
                  _buildServiceCard(context, "Doctor Feedback Portal", Icons.person_search_outlined, '/doctors'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE6F7FA),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFB2EBF2).withOpacity(0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}