import 'package:flutter/material.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. TOP NAVIGATION BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, color: Color(0xFF4DD0E1)),
                  Image.asset('assets/images/Medicuratext.png', height: 40),
                  const Icon(Icons.notifications, color: Color(0xFF4DD0E1)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // 2. EMERGENCY SOS TITLE
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "EMERGENCY SOS",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "Press the Button Below to contact\nMedical Assistance",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 14),
                    ),

                    const SizedBox(height: 20),

                    // 3. GUARDIAN CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7F2), // Light peach background
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFB2EBF2).withOpacity(0.5)),
                      ),
                      child: Column(
                        children: [
                          _buildGuardianHeader(),
                          const SizedBox(height: 10),
                          const Text("Guardian to be Notified", style: TextStyle(fontSize: 12, color: Colors.black54)),
                          const SizedBox(height: 10),
                          _buildGuardianInfo(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 4. LARGE SOS BUTTON
                    GestureDetector(
                      onTap: () {
                        // Logic for SOS call/notification
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 20, spreadRadius: 5),
                          ],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone_in_talk, color: Colors.white, size: 50),
                            Text("SOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 5. ALERT BANNER
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE), // Light red alert background
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.red.shade100),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.notifications_active, color: Colors.red, size: 40),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Emergency Alert Detected",
                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14)),
                              Text("Abnormal Amount of Cholesterol Detected",
                                  style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuardianHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.shade800,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Text("Notify Guardian/\nCaretaker",
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildGuardianInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFFB2EBF2)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.orangeAccent,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Maheen Tariq", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text("+92 333 9018302", style: TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFC5CAE9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text("Mother", style: TextStyle(color: Colors.indigo, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}