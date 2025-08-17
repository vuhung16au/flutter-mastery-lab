import 'package:flutter/material.dart';

// Page 3: Input Widgets - Demonstrates TextField and other input widgets
class InputWidgetsPage extends StatefulWidget {
  const InputWidgetsPage({super.key});

  @override
  State<InputWidgetsPage> createState() => _InputWidgetsPageState();
}

class _InputWidgetsPageState extends State<InputWidgetsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sydney Input Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // TextField Widget demonstration
          const Text(
            'TextField Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Sydney Suburb',
              hintText: 'Enter your suburb',
              prefixIcon: Icon(Icons.location_city),
              border: OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: const OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 20),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Suburb: ${_nameController.text}\n'
                      'Email: ${_emailController.text}\n'
                      'Password: ${_passwordController.text}',
                    ),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Other input widgets
          const Text(
            'Other Input Widgets:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          
          // Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Enable Sydney weather alerts'),
              Switch(
                value: true,
                onChanged: (value) {
                  // Handle switch change
                },
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Checkbox
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {
                  // Handle checkbox change
                },
              ),
              const Text('I agree to Sydney terms and conditions'),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Radio buttons
          const Text('Select your favorite Sydney beach:'),
          RadioListTile<String>(
            title: const Text('Bondi'),
            value: 'bondi',
            groupValue: 'bondi',
            onChanged: (value) {
              // Handle radio change
            },
          ),
          RadioListTile<String>(
            title: const Text('Manly'),
            value: 'manly',
            groupValue: 'bondi',
            onChanged: (value) {
              // Handle radio change
            },
          ),
          RadioListTile<String>(
            title: const Text('Coogee'),
            value: 'coogee',
            groupValue: 'bondi',
            onChanged: (value) {
              // Handle radio change
            },
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
