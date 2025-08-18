import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/widgets/forms/form_header_card.dart';
import 'package:flutter_forms_gestures/widgets/forms/form_field.dart';
import 'package:flutter_forms_gestures/widgets/forms/form_buttons.dart';

class FormSubmissionPage extends StatefulWidget {
  const FormSubmissionPage({super.key});

  @override
  State<FormSubmissionPage> createState() => _FormSubmissionPageState();
}

class _FormSubmissionPageState extends State<FormSubmissionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  
  String _selectedCategory = 'General';
  bool _isSubscribed = false;
  bool _isSubmitting = false;
  
  final List<String> _categories = [
    'General',
    'Support',
    'Feedback',
    'Bug Report',
    'Feature Request',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isSubmitting = false);
      if (mounted) {
        _showSuccessDialog();
        _resetForm();
      }
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
    setState(() {
      _selectedCategory = 'General';
      _isSubscribed = false;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Success!'),
            ],
          ),
          content: const Text('Your form has been submitted successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Submission Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormHeaderCard(
                title: 'Contact Form',
                subtitle: 'Fill out the form below to submit your information',
              ),
              const SizedBox(height: 16),
              
              CustomFormField(
                controller: _nameController,
                label: 'Full Name *',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your name';
                  if (value.length < 2) return 'Name must be at least 2 characters';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              CustomFormField(
                controller: _emailController,
                label: 'Email Address *',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              CustomFormField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^\+?[\d\s-\(\)]+$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              DropdownFormField(
                label: 'Category *',
                icon: Icons.category,
                initialValue: _selectedCategory,
                items: _categories,
                onChanged: (String? newValue) {
                  setState(() => _selectedCategory = newValue!);
                },
              ),
              const SizedBox(height: 16),
              
              CustomFormField(
                controller: _messageController,
                label: 'Message *',
                icon: Icons.message,
                maxLines: 4,
                alignLabelWithHint: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a message';
                  if (value.length < 10) return 'Message must be at least 10 characters';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              CheckboxFormField(
                title: 'Subscribe to newsletter',
                subtitle: 'Receive updates and news',
                value: _isSubscribed,
                onChanged: (bool? value) {
                  setState(() => _isSubscribed = value!);
                },
              ),
              const SizedBox(height: 24),
              
              FormButtons(
                onSubmit: _submitForm,
                onReset: _resetForm,
                isSubmitting: _isSubmitting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
