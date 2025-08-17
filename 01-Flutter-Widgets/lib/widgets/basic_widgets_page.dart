import 'package:flutter/material.dart';

// Page 1: Basic Widgets - Demonstrates Container, SizedBox, ClipRRect, RichText
class BasicWidgetsPage extends StatelessWidget {
  const BasicWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sydney Basic Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Container Widget demonstration
          const Text(
            'Container Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Welcome to Sydney Harbour',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // SizedBox Widget demonstration
          const Text(
            'SizedBox Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Container(
                  color: Colors.red.shade100,
                  child: const Center(child: Text('Bondi')),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                height: 60,
                child: Container(
                  color: Colors.green.shade100,
                  child: const Center(child: Text('Manly Beach')),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // ClipRRect Widget demonstration
          const Text(
            'ClipRRect Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: 80,
              color: Colors.purple.shade100,
              child: const Center(
                child: Text(
                  'Sydney Opera House',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // RichText Widget demonstration
          const Text(
            'RichText Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black),
              children: [
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'Sydney',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: ', the beautiful ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'harbour city',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: ' of Australia!',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
