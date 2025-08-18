import 'package:flutter/material.dart';

class FormSubmissionPage extends StatelessWidget {
  const FormSubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Submission Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('Form Submission Demo'),
      ),
    );
  }
}
