import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';

class DoctorsListPage extends StatelessWidget {
  const DoctorsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find a Doctor"), backgroundColor: AppTheme.primaryTeal),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const CircleAvatar(radius: 30, backgroundColor: AppTheme.cardBackground, child: Icon(Icons.person, color: AppTheme.primaryTeal)),
              title: Text("Dr. Specialist ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("Cardiologist • Available"),
              trailing: IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: AppTheme.primaryTeal),
                onPressed: () => context.push('/doctor_chat'), // Navigates to the Doctor Chat
              ),
            ),
          );
        },
      ),
    );
  }
}