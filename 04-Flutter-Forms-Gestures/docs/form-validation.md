# Form Validation in Flutter

## Overview
This component demonstrates how to implement comprehensive form validation in Flutter applications, including real-time validation, error handling, and form state management.

## Key Components Used

### 1. Form
- **Purpose**: Container widget that manages form state and validation
- **Usage**: Wraps form fields and provides validation context

### 2. TextFormField
- **Purpose**: Input field with built-in validation support
- **Usage**: Collects user input with validation rules

### 3. GlobalKey<FormState>
- **Purpose**: Provides access to form state and validation methods
- **Usage**: Triggers validation and form submission

### 4. FormFieldValidator
- **Purpose**: Function that validates form field input
- **Usage**: Returns error message or null if valid

## Implementation Steps

1. **Create Form with GlobalKey**:
   ```dart
   final _formKey = GlobalKey<FormState>();
   
   Form(
     key: _formKey,
     child: Column(
       children: [
         // Form fields here
       ],
     ),
   )
   ```

2. **Add TextFormField with Validation**:
   ```dart
   TextFormField(
     decoration: InputDecoration(labelText: 'Email'),
     validator: (value) {
       if (value == null || value.isEmpty) {
         return 'Please enter your email';
       }
       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
         return 'Please enter a valid email';
       }
       return null;
     },
   )
   ```

3. **Handle Form Submission**:
   ```dart
   if (_formKey.currentState!.validate()) {
     // Form is valid, proceed with submission
     _formKey.currentState!.save();
   }
   ```

## Validation Types
- **Required Field Validation**: Ensures field is not empty
- **Email Validation**: Validates email format
- **Password Validation**: Checks password strength
- **Length Validation**: Ensures minimum/maximum length
- **Custom Validation**: Business logic validation

## Best Practices
- Provide clear error messages
- Validate in real-time when appropriate
- Use appropriate input types
- Consider accessibility
- Test validation thoroughly
