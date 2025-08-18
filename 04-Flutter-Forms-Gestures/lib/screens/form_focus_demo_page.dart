import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/widgets/forms/form_header_card.dart';
import 'package:flutter_forms_gestures/widgets/forms/form_status_cards.dart';
import 'package:flutter_forms_gestures/widgets/forms/focus_form_fields.dart';
import 'package:flutter_forms_gestures/widgets/forms/focus_form_buttons.dart';
import 'package:flutter_forms_gestures/widgets/forms/focus_instructions.dart';

class FormFocusDemoPage extends StatefulWidget {
  const FormFocusDemoPage({super.key});

  @override
  State<FormFocusDemoPage> createState() => _FormFocusDemoPageState();
}

class _FormFocusDemoPageState extends State<FormFocusDemoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  
  // Focus nodes for managing focus
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _notesFocusNode = FocusNode();
  
  // State variables
  String _currentFocusField = 'None';
  String _lastChangedField = 'None';
  int _characterCount = 0;
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isPhoneValid = false;
  
  @override
  void initState() {
    super.initState();
    
    // Add listeners to controllers for real-time validation
    _nameController.addListener(_onNameChanged);
    _emailController.addListener(_onEmailChanged);
    _phoneController.addListener(_onPhoneChanged);
    _notesController.addListener(_onNotesChanged);
    
    // Add focus listeners
    _nameFocusNode.addListener(() => _onFocusChanged('Name', _nameFocusNode.hasFocus));
    _emailFocusNode.addListener(() => _onFocusChanged('Email', _emailFocusNode.hasFocus));
    _phoneFocusNode.addListener(() => _onFocusChanged('Phone', _phoneFocusNode.hasFocus));
    _notesFocusNode.addListener(() => _onFocusChanged('Notes', _notesFocusNode.hasFocus));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _notesFocusNode.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    final value = _nameController.text;
    setState(() {
      _lastChangedField = 'Name';
      _isNameValid = value.length >= 2 && RegExp(r'^[a-zA-Z\s]+$').hasMatch(value);
    });
  }

  void _onEmailChanged() {
    final value = _emailController.text;
    setState(() {
      _lastChangedField = 'Email';
      _isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    });
  }

  void _onPhoneChanged() {
    final value = _phoneController.text;
    setState(() {
      _lastChangedField = 'Phone';
      _isPhoneValid = value.isEmpty || RegExp(r'^\+?[\d\s-\(\)]{10,}$').hasMatch(value);
    });
  }

  void _onNotesChanged() {
    final value = _notesController.text;
    setState(() {
      _lastChangedField = 'Notes';
      _characterCount = value.length;
    });
  }

  void _onFocusChanged(String fieldName, bool hasFocus) {
    setState(() {
      if (hasFocus) {
        _currentFocusField = fieldName;
      } else if (_currentFocusField == fieldName) {
        _currentFocusField = 'None';
      }
    });
  }

  void _moveToNextField() {
    if (_nameFocusNode.hasFocus) {
      _emailFocusNode.requestFocus();
    } else if (_emailFocusNode.hasFocus) {
      _phoneFocusNode.requestFocus();
    } else if (_phoneFocusNode.hasFocus) {
      _notesFocusNode.requestFocus();
    } else if (_notesFocusNode.hasFocus) {
      _notesFocusNode.unfocus();
    }
  }

  void _clearAllFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _notesController.clear();
    _nameFocusNode.unfocus();
    setState(() {
      _currentFocusField = 'None';
      _lastChangedField = 'None';
      _characterCount = 0;
      _isNameValid = false;
      _isEmailValid = false;
      _isPhoneValid = false;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Focus & Changes Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: _moveToNextField,
            tooltip: 'Next Field',
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearAllFields,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormHeaderCard(
                title: 'Focus Management Demo',
                subtitle: 'Demonstrating focus handling and real-time field changes',
              ),
              const SizedBox(height: 16),
              
              // Status Cards
              FormStatusCards(
                currentFocusField: _currentFocusField,
                lastChangedField: _lastChangedField,
                characterCount: _characterCount,
                isNameValid: _isNameValid,
                isEmailValid: _isEmailValid,
                isPhoneValid: _isPhoneValid,
              ),
              const SizedBox(height: 16),
              
              // Form Fields
              FocusFormFields(
                nameController: _nameController,
                emailController: _emailController,
                phoneController: _phoneController,
                notesController: _notesController,
                nameFocusNode: _nameFocusNode,
                emailFocusNode: _emailFocusNode,
                phoneFocusNode: _phoneFocusNode,
                notesFocusNode: _notesFocusNode,
                isNameValid: _isNameValid,
                isEmailValid: _isEmailValid,
                isPhoneValid: _isPhoneValid,
                characterCount: _characterCount,
                onMoveToNextField: _moveToNextField,
                onUnfocusNotes: () => _notesFocusNode.unfocus(),
              ),
              const SizedBox(height: 24),
              
              // Instructions Card
              const FocusInstructions(),
              const SizedBox(height: 24),
              
              // Form Buttons
              FocusFormButtons(
                onSubmit: _submitForm,
                onClearAll: _clearAllFields,
              ),
            ],
          ),
        ),
      ),
    );
  }




}
