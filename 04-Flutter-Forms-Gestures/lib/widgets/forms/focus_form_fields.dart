import 'package:flutter/material.dart';

class FocusFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController notesController;
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode notesFocusNode;
  final bool isNameValid;
  final bool isEmailValid;
  final bool isPhoneValid;
  final int characterCount;
  final VoidCallback onMoveToNextField;
  final VoidCallback onUnfocusNotes;

  const FocusFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.notesController,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.phoneFocusNode,
    required this.notesFocusNode,
    required this.isNameValid,
    required this.isEmailValid,
    required this.isPhoneValid,
    required this.characterCount,
    required this.onMoveToNextField,
    required this.onUnfocusNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          focusNode: nameFocusNode,
          decoration: InputDecoration(
            labelText: 'Full Name',
            prefixIcon: const Icon(Icons.person),
            suffixIcon: isNameValid 
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            border: const OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => onMoveToNextField(),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Name is required';
            if (value.length < 2) return 'Name must be at least 2 characters';
            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
              return 'Name can only contain letters and spaces';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: emailController,
          focusNode: emailFocusNode,
          decoration: InputDecoration(
            labelText: 'Email Address',
            prefixIcon: const Icon(Icons.email),
            suffixIcon: isEmailValid 
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => onMoveToNextField(),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Email is required';
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: phoneController,
          focusNode: phoneFocusNode,
          decoration: InputDecoration(
            labelText: 'Phone Number (Optional)',
            prefixIcon: const Icon(Icons.phone),
            suffixIcon: isPhoneValid 
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => onMoveToNextField(),
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (!RegExp(r'^\+?[\d\s-\(\)]{10,}$').hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: notesController,
          focusNode: notesFocusNode,
          decoration: InputDecoration(
            labelText: 'Notes',
            prefixIcon: const Icon(Icons.note),
            suffixText: '$characterCount chars',
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => onUnfocusNotes(),
        ),
      ],
    );
  }
}
