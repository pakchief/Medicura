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
    setState(() => _isLoading = true);
    final user = Supabase.instance.client.auth.currentUser;

    try {
      await Supabase.instance.client.from('profiles').upsert({
        'id': user!.id,
        'full_name': _nameController.text.trim(),
        'age': _ageController.text.trim(),
        'gender': _gender,
      });
      if (mounted) context.go('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text('Tell us about yourself', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _buildCardSection('Basic Info', [
              CustomTextField(hintText: 'Full Name', suffixIcon: Icons.person, controller: _nameController),
              CustomTextField(hintText: 'Age', suffixIcon: Icons.calendar_today, controller: _ageController),
              _buildGenderRadio(),
            ]),
            const SizedBox(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : PrimaryButton(text: 'Submit', onPressed: _savePreferences),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['Male', 'Female'].map((g) => Row(
        children: [
          Radio(value: g, groupValue: _gender, onChanged: (v) => setState(() => _gender = v.toString())),
          Text(g),
        ],
      )).toList(),
    );
  }

  Widget _buildCardSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppTheme.cardBackground, borderRadius: BorderRadius.circular(20)),
      child: Column(children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), ...children]),
    );
  }
}