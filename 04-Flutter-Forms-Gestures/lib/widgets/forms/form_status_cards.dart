import 'package:flutter/material.dart';

class FormStatusCards extends StatelessWidget {
  final String currentFocusField;
  final String lastChangedField;
  final int characterCount;
  final bool isNameValid;
  final bool isEmailValid;
  final bool isPhoneValid;

  const FormStatusCards({
    super.key,
    required this.currentFocusField,
    required this.lastChangedField,
    required this.characterCount,
    required this.isNameValid,
    required this.isEmailValid,
    required this.isPhoneValid,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status Cards
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildStatusRow('Current Focus:', currentFocusField, Icons.visibility),
                _buildStatusRow('Last Changed:', lastChangedField, Icons.edit),
                _buildStatusRow('Character Count:', '$characterCount', Icons.text_fields),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Validation Status
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Validation Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildValidationRow('Name', isNameValid),
                _buildValidationRow('Email', isEmailValid),
                _buildValidationRow('Phone', isPhoneValid),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              color: value == 'None' ? Colors.grey : Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationRow(String field, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.circle_outlined,
            color: isValid ? Colors.green : Colors.grey,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            field,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Text(
            isValid ? 'Valid' : 'Invalid',
            style: TextStyle(
              color: isValid ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
