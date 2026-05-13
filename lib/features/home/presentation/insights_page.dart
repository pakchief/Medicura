import 'package:flutter/material.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';

class HealthInsightsPage extends StatelessWidget {
  const HealthInsightsPage({super.key});

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
                  Image.asset('assets/images/Medicuratext.png', height: 25),
                  const Icon(Icons.notifications, color: Color(0xFF4DD0E1)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // 2. STATUS BANNER
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E93B9),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Status: ',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              children: [
                                TextSpan(
                                  text: 'Improving',
                                  style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Last Updated: 14th April 2026',
                            style: TextStyle(color: Colors.white70, fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 3. ANALYTICS / CHARTS SECTION (Placeholder Image)
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/images/health.png')
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 4. INSIGHT CARDS
                    _buildInsightCard("AI Insights", [
                      "Your blood sugar levels are improving",
                      "Continue your medication routine",
                      "Stay hydrated and maintain your diet"
                    ]),
                    _buildInsightCard("Alerts", [
                      "Slight increase in cholesterol",
                      "Monitor blood pressure regularly"
                    ]),
                    _buildInsightCard("Achievements", [
                      "Completed 7-day medication plan",
                      "Improved hemoglobin levels"
                    ]),
                    _buildInsightCard("Reminders", [
                      "Medication reminder (time + name + checkbox)",
                      "Health activity reminder (water, walk)"
                    ]),

                    const SizedBox(height: 80), // Space for bottom navbar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(String title, List<String> bulletPoints) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFB2EBF2).withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header of the card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF2E93B9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          // Content of the card
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: bulletPoints.map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "• $point",
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}