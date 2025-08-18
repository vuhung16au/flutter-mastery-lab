import 'package:flutter/material.dart';

class FormButtons extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onReset;
  final bool isSubmitting;
  final String submitText;
  final String resetText;

  const FormButtons({
    super.key,
    required this.onSubmit,
    required this.onReset,
    required this.isSubmitting,
    this.submitText = 'Submit Form',
    this.resetText = 'Reset Form',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: isSubmitting ? null : onSubmit,
          icon: isSubmitting 
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.send),
          label: Text(isSubmitting ? 'Submitting...' : submitText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: isSubmitting ? null : onReset,
          icon: const Icon(Icons.refresh),
          label: Text(resetText),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }
}
