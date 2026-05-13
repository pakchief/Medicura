import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';
import 'package:medicuraapp/shared/widgets/primary_button.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _otherDiseaseController = TextEditingController();

  String _gender = 'Female';
  bool _hasMedication = true;
  bool _isLoading = false;

  // Chronic Disease States
  final Map<String, bool> _diseases = {
    'Blood Pressure': false,
    'Diabetes': false,
    'Heart Disease': false,
    'Thyroid Disorder': false,
    'Asthma': false,
  };

  Future<void> _savePreferences() async {
    setState(() => _isLoading = true);
    final user = Supabase.instance.client.auth.currentUser;

    // Filter selected diseases
    List<String> selectedDiseases = _diseases.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
    if (_otherDiseaseController.text.isNotEmpty) {
      selectedDiseases.add(_otherDiseaseController.text.trim());
    }

    try {
      await Supabase.instance.client.from('profiles').upsert({
        'id': user!.id,
        'full_name': _nameController.text.trim(),
        'age': _ageController.text.trim(),
        'gender': _gender,
        'chronic_diseases': selectedDiseases,
        // Using medication status for now, can be expanded to full JSON later
        'website': _hasMedication ? "On Medication" : "No Medication",
      });
      if (mounted) context.go('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/Medicuratext.png', height: 35),
              const SizedBox(height: 20),
              const Text('Tell us about yourself',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              const SizedBox(height: 20),
              _buildSection("Basic Info", _buildBasicInfo()),

              const SizedBox(height: 20),
              _buildSection("Any Chronic disease", _buildChronicInfo()),

              const SizedBox(height: 20),
              _buildSection("Medications", _buildMedicationInfo()),

              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator(color: AppTheme.primaryTeal)
                  : PrimaryButton(text: 'Submit', onPressed: _savePreferences),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7FA),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFB2EBF2).withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 18, color: Colors.black87)),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildSmallField("Full Name", _nameController)),
            const SizedBox(width: 10),
            Expanded(child: _buildSmallField("Age", _ageController)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ['Male', 'Female', 'Other'].map((g) => Row(
            children: [
              Radio(
                value: g,
                groupValue: _gender,
                onChanged: (v) => setState(() => _gender = v.toString()),
                activeColor: Colors.black,
              ),
              Text(g, style: const TextStyle(fontSize: 12)),
            ],
          )).toList(),
        )
      ],
    );
  }

  Widget _buildChronicInfo() {
    return Column(
      children: [
        Wrap(
          spacing: 10,
          children: _diseases.keys.map((d) => SizedBox(
            width: 140,
            child: Row(
              children: [
                Checkbox(
                  value: _diseases[d],
                  onChanged: (v) => setState(() => _diseases[d] = v!),
                  activeColor: AppTheme.primaryTeal,
                ),
                Expanded(child: Text(d, style: const TextStyle(fontSize: 11))),
              ],
            ),
          )).toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: _otherDiseaseController,
            decoration: const InputDecoration(
              hintText: "Other ________________________________",
              hintStyle: TextStyle(fontSize: 12),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMedicationInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRadioMed("yes", true),
            _buildRadioMed("No", false),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildSmallField("Medicine Name", null)),
            const SizedBox(width: 10),
            Expanded(child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 35,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dosage Frequency", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Icon(Icons.arrow_drop_down, size: 18),
                ],
              ),
            )),
          ],
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_circle_outline, size: 14),
          label: const Text("Add Another Medicine", style: TextStyle(fontSize: 10)),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            side: const BorderSide(color: Colors.grey, width: 0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        )
      ],
    );
  }

  Widget _buildRadioMed(String label, bool value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _hasMedication,
          onChanged: (v) => setState(() => _hasMedication = v as bool),
          activeColor: Colors.black,
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildSmallField(String hint, TextEditingController? controller) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }
}