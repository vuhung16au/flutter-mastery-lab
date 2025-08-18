import 'package:flutter/material.dart';
import 'form_validation_page.dart';
import 'form_submission_page.dart';
import 'gestures_demo_page.dart';
import 'dismissible_demo_page.dart';
import 'drag_demo_page.dart';
import 'package:flutter_forms_gestures/widgets/home/demo_button.dart';
import 'package:flutter_forms_gestures/widgets/home/section_header.dart';
import 'package:flutter_forms_gestures/widgets/home/features_summary.dart';

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
            const SectionHeader(title: 'Forms', icon: Icons.edit_document),
            const SizedBox(height: 12),
            DemoButton(
              title: 'Form Validation Demo',
              description: 'Validate form inputs with real-time feedback',
              icon: Icons.verified,
              color: Colors.blue,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormValidationPage()),
              ),
            ),
            const SizedBox(height: 8),
            DemoButton(
              title: 'Form Submission Demo',
              description: 'Submit forms with data handling',
              icon: Icons.send,
              color: Colors.green,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormSubmissionPage()),
              ),
            ),

            const SizedBox(height: 24),

            // Gestures Section
            const SectionHeader(title: 'Gestures', icon: Icons.touch_app),
            const SizedBox(height: 12),
            DemoButton(
              title: 'Complete Gestures Demo',
              description: 'All gesture types from TutorialsPoint & Flutter Docs',
              icon: Icons.gesture,
              color: Colors.purple,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GesturesDemoPage()),
              ),
            ),
            const SizedBox(height: 8),
            DemoButton(
              title: 'Swipe to Dismiss Demo',
              description: 'Dismissible widget with undo functionality',
              icon: Icons.swipe,
              color: Colors.orange,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DismissibleDemoPage()),
              ),
            ),
            const SizedBox(height: 8),
            DemoButton(
              title: 'Drag & Drop Demo',
              description: 'Draggable widgets with drop zones',
              icon: Icons.drag_handle,
              color: Colors.teal,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DragDemoPage()),
              ),
            ),

            const SizedBox(height: 24),

            // Features Summary
            const FeaturesSummary(),
          ],
        ),
      ),
    );
  }
}
