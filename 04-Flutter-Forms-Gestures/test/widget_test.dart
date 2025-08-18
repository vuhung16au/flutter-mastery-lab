// This is a basic Flutter widget test for the Forms & Gestures demo app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_forms_gestures/main.dart';

void main() {
  testWidgets('Forms & Gestures app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FormsGesturesApp());

    // Verify that the main page loads with the correct title
    expect(find.text('Flutter Forms & Gestures'), findsOneWidget);
    expect(find.text('Flutter Forms & Gestures Demo'), findsOneWidget);

    // Verify that all main navigation buttons are present
    expect(find.text('Form Validation Demo'), findsOneWidget);
    expect(find.text('Form Submission Demo'), findsOneWidget);
    expect(find.text('Complete Gestures Demo'), findsOneWidget);
    expect(find.text('Swipe to Dismiss Demo'), findsOneWidget);
    expect(find.text('Drag & Drop Demo'), findsOneWidget);
  });

  testWidgets('Form Validation page navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FormsGesturesApp());

    // Tap the Form Validation Demo button
    await tester.tap(find.text('Form Validation Demo'));
    await tester.pumpAndSettle();

    // Verify that we're on the Form Validation page
    expect(find.text('Form Validation Demo'), findsOneWidget);
    expect(find.text('Form Validation Example'), findsOneWidget);

    // Verify that form fields are present
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
  });

  testWidgets('Form Submission page navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FormsGesturesApp());

    // Tap the Form Submission Demo button
    await tester.tap(find.text('Form Submission Demo'));
    await tester.pumpAndSettle();

    // Verify that we're on the Form Submission page
    expect(find.text('Form Submission Demo'), findsOneWidget); // AppBar title
    expect(find.text('Contact Form'), findsOneWidget); // Main form title
    expect(find.text('Full Name *'), findsOneWidget); // Form field
    expect(find.text('Email Address *'), findsOneWidget); // Form field
  });

  testWidgets('Complete Gestures page navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FormsGesturesApp());

    // Tap the Complete Gestures Demo button
    await tester.tap(find.text('Complete Gestures Demo'));
    await tester.pumpAndSettle();

    // Verify that we're on the Gestures page
    expect(find.text('Flutter Gestures Demo'), findsAtLeastNWidgets(1)); // AppBar title and main title
    expect(find.text('Gesture Status'), findsOneWidget); // Status section
  });

  testWidgets('Swipe to Dismiss page navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FormsGesturesApp());

    // Tap the Swipe to Dismiss Demo button
    await tester.tap(find.text('Swipe to Dismiss Demo'));
    await tester.pumpAndSettle();

    // Verify that we're on the Dismissible page
    expect(find.text('Swipe to Dismiss Demo'), findsAtLeastNWidgets(1)); // AppBar title and main title
  });

  testWidgets('Drag & Drop page navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FormsGesturesApp());

    // Scroll to make sure the Drag & Drop button is visible
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Tap the Drag & Drop Demo button
    await tester.tap(find.text('Drag & Drop Demo'), warnIfMissed: false);
    await tester.pumpAndSettle();

    // Verify that we're on the Drag page
    expect(find.text('Drag Demo'), findsAtLeastNWidgets(1)); // AppBar title and main title
  });
}
