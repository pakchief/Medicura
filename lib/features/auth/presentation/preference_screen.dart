import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';
import 'package:medicuraapp/shared/widgets/primary_button.dart';
import 'package:medicuraapp/shared/widgets/custom_textfield.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _gender = 'Female';
  bool _isLoading = false;

  Future<void> _savePreferences() async {
    // 1. Check if name and age are filled
    if (_nameController.text.isEmpty || _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() => _isLoading = true);
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User not found. Please log in again.")));
      setState(() => _isLoading = false);
      return;
    }

    try {
      // 2. Save directly to the updated Supabase columns
      await Supabase.instance.client.from('profiles').upsert({
        'id': user.id,
        'full_name': _nameController.text.trim(),
        'age': _ageController.text.trim(),
        'gender': _gender,
      });

      // 3. Move to the Home Screen!
      if (mounted) context.go('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error saving profile: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text('MEDICURA', style: AppTheme.titleStyle),
              const SizedBox(height: 20),
              const Text('Personalize Your AI', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text('Basic Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 15),
                    CustomTextField(hintText: 'Full Name', suffixIcon: Icons.person, controller: _nameController),
                    CustomTextField(hintText: 'Age', suffixIcon: Icons.calendar_today, controller: _ageController),
                    const SizedBox(height: 10),
                    _buildGenderPicker(),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator(color: AppTheme.primaryTeal)
                  : PrimaryButton(text: 'Continue to MediCura', onPressed: _savePreferences),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['Male', 'Female'].map((g) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
              value: g,
              groupValue: _gender,
              activeColor: AppTheme.primaryTeal,
              onChanged: (v) => setState(() => _gender = v.toString())
          ),
          Text(g),
        ],
      )).toList(),
    );
  }
}