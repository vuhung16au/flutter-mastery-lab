import 'package:flutter/material.dart';
import 'form_validation_page.dart';
import 'form_submission_page.dart';
import 'gestures_demo_page.dart';
import 'dismissible_demo_page.dart';
import 'drag_demo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Forms & Gestures'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Flutter Forms & Gestures Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Complete gesture implementation based on Flutter documentation',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Forms Section
            _buildSectionHeader('Forms', Icons.edit_document),
            const SizedBox(height: 12),
            _buildDemoButton(
              context,
              'Form Validation Demo',
              'Validate form inputs with real-time feedback',
              Icons.verified,
              Colors.blue,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormValidationPage()),
              ),
            ),
            const SizedBox(height: 8),
            _buildDemoButton(
              context,
              'Form Submission Demo',
              'Submit forms with data handling',
              Icons.send,
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormSubmissionPage()),
              ),
            ),

            const SizedBox(height: 24),

            // Gestures Section
            _buildSectionHeader('Gestures', Icons.touch_app),
            const SizedBox(height: 12),
            _buildDemoButton(
              context,
              'Complete Gestures Demo',
              'All gesture types from TutorialsPoint & Flutter Docs',
              Icons.gesture,
              Colors.purple,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GesturesDemoPage()),
              ),
            ),
            const SizedBox(height: 8),
            _buildDemoButton(
              context,
              'Swipe to Dismiss Demo',
              'Dismissible widget with undo functionality',
              Icons.swipe,
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DismissibleDemoPage()),
              ),
            ),
            const SizedBox(height: 8),
            _buildDemoButton(
              context,
              'Drag & Drop Demo',
              'Draggable widgets with drop zones',
              Icons.drag_handle,
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DragDemoPage()),
              ),
            ),

            const SizedBox(height: 24),

            // Features Summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Implemented Features',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem('✅ All TutorialsPoint gestures', 'Tap, Double Tap, Drag, Flick, Pinch, Spread, Panning'),
                    _buildFeatureItem('✅ Material Design ripples', 'InkWell for proper touch feedback'),
                    _buildFeatureItem('✅ Swipe to dismiss', 'Dismissible widget with confirmation'),
                    _buildFeatureItem('✅ Drag and drop', 'Draggable widgets with drop zones'),
                    _buildFeatureItem('✅ Form validation', 'Real-time validation with error handling'),
                    _buildFeatureItem('✅ Visual feedback', 'Snackbars, animations, and status updates'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildDemoButton(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                                 decoration: BoxDecoration(
                   color: color.withValues(alpha: 0.1),
                   borderRadius: BorderRadius.circular(8),
                 ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
