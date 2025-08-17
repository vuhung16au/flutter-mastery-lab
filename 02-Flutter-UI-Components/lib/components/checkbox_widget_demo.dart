import 'package:flutter/material.dart';

class CheckboxWidgetDemo extends StatefulWidget {
  const CheckboxWidgetDemo({super.key});

  @override
  State<CheckboxWidgetDemo> createState() => _CheckboxWidgetDemoState();
}

class _CheckboxWidgetDemoState extends State<CheckboxWidgetDemo> {
  bool _isChecked1 = false;
  bool _isChecked2 = true;
  bool _isChecked3 = false;
  final bool _isChecked4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox Widget Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Checkboxes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Simple checkbox'),
              value: _isChecked1,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked1 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Pre-checked checkbox'),
              value: _isChecked2,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked2 = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Custom Styled Checkboxes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Custom colors'),
              subtitle: const Text('Red when checked, blue when unchecked'),
              value: _isChecked3,
              activeColor: Colors.red,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked3 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Disabled checkbox'),
              subtitle: const Text('This checkbox cannot be changed'),
              value: _isChecked4,
              onChanged: null, // This makes it disabled
            ),
            const SizedBox(height: 20),
            const Text(
              'Individual Checkboxes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isChecked1,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked1 = value!;
                    });
                  },
                ),
                const Text('Individual checkbox 1'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _isChecked2,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked2 = value!;
                    });
                  },
                ),
                const Text('Individual checkbox 2'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Current States:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Checkbox 1: ${_isChecked1 ? "Checked" : "Unchecked"}'),
            Text('Checkbox 2: ${_isChecked2 ? "Checked" : "Unchecked"}'),
            Text('Checkbox 3: ${_isChecked3 ? "Checked" : "Unchecked"}'),
            Text('Checkbox 4: ${_isChecked4 ? "Checked" : "Unchecked"}'),
          ],
        ),
      ),
    );
  }
}
