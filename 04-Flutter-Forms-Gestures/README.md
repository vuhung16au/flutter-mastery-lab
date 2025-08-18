# Flutter Forms & Gestures Demo

A comprehensive Flutter application demonstrating form validation, form submission, and gesture handling capabilities.

## Project Overview

This project showcases three main components of Flutter development:

1. **Form Validation in Flutter**
2. **Form Submission Page Design**
3. **Gesture Recognition and Handling**

## Features

### 1. Form Validation Demo
- **Real-time validation** for user inputs
- **Custom validation rules** for different field types:
  - Name: Letters and spaces only, minimum 2 characters
  - Email: Standard email format validation
  - Password: Complex password requirements (uppercase, lowercase, numbers, minimum 8 characters)
  - Phone: International phone number format support
- **Visual feedback** with error messages
- **Form state management** using GlobalKey

### 2. Form Submission Demo
- **Complete form workflow** with submission simulation
- **Loading states** with progress indicators
- **Category selection** using dropdown menus
- **Multi-line text input** for descriptions
- **Success feedback** with SnackBar notifications
- **Form reset** functionality after successful submission

### 3. Gestures Demo
- **Multiple gesture recognition**:
  - Tap gestures with counter
  - Long press with rotation animation
  - Double tap with scale animation
  - Drag gestures with coordinate tracking
- **Real-time gesture statistics** display
- **Smooth animations** using AnimationController
- **Interactive visual feedback** for all gestures

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository
2. Navigate to the project directory:
   ```bash
   cd 04-Flutter-Forms-Gestures
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Usage

### Main Navigation
The app provides a clean navigation interface with three main sections:

1. **Form Validation Demo** - Learn about input validation
2. **Form Submission Demo** - Experience complete form workflows
3. **Gestures Demo** - Interact with various touch gestures

### Form Validation Features
- Enter invalid data to see real-time validation errors
- Try different email formats to test email validation
- Test password strength requirements
- Experience phone number format validation

### Form Submission Features
- Fill out the complete post creation form
- Select categories from the dropdown
- Submit and watch the loading animation
- See success feedback and form reset

### Gesture Features
- **Tap** the interactive area to see tap counter increase
- **Long press** to trigger rotation animation
- **Double tap** for scale animation
- **Drag** to move the gesture area around
- Monitor gesture statistics in real-time

## Security

### Security Scanning
This project includes comprehensive security scanning to prevent sensitive information from being committed to version control.

#### Available Scripts
- `scripts/security_scan.sh` - Main security scanner
- `scripts/test_security_scan.sh` - Test script to demonstrate scanning capabilities
- `scripts/setup_git_hooks.sh` - Setup automatic security scanning on commits

#### Usage
```bash
# Run security scan
./scripts/security_scan.sh

# Test the scanner with sample data
./scripts/test_security_scan.sh

# Setup git hooks for automatic scanning
./scripts/setup_git_hooks.sh
```

#### What it scans for
- API keys and tokens
- Passwords and credentials
- Database connection strings
- AWS and cloud service keys
- Hardcoded sensitive values
- Environment files
- Git history for sensitive data

For more details, see [scripts/README.md](scripts/README.md).

## Technical Implementation

### Form Validation
- Uses `GlobalKey<FormState>` for form management
- Custom validator functions for each field type
- Regular expressions for pattern matching
- Real-time validation feedback

### Form Submission
- Simulated API calls with `Future.delayed`
- Loading state management
- Form reset functionality
- User feedback with SnackBar

### Gestures
- `GestureDetector` widget for gesture recognition
- `AnimationController` for smooth animations
- State management for gesture counters
- Real-time coordinate tracking

## Dependencies

The project uses only Flutter's built-in packages:
- `flutter/material.dart` - Core Flutter framework
- No external dependencies required

## Project Structure

```
lib/
├── main.dart                 # Main application entry point
│   ├── FormsGesturesApp     # Root app widget
│   ├── HomePage             # Navigation home page
│   ├── FormValidationPage   # Form validation demo
│   ├── FormSubmissionPage   # Form submission demo
│   └── GesturesDemoPage     # Gestures demo
```

## Learning Objectives

After completing this project, you will understand:

1. **Form Validation**
   - How to implement custom validation rules
   - Real-time validation feedback
   - Form state management

2. **Form Submission**
   - Complete form workflow implementation
   - Loading states and user feedback
   - Form reset and data management

3. **Gesture Handling**
   - Various gesture types and their implementation
   - Animation integration with gestures
   - Real-time gesture tracking and statistics

## Contributing

This is a learning project. Feel free to experiment with:
- Adding new validation rules
- Implementing additional gestures
- Enhancing the UI/UX
- Adding new form fields or features

## License

This project is for educational purposes.
