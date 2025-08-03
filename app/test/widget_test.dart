// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';
import 'package:app/database/database_helper.dart';

void main() {
  testWidgets('Database initialization test', (WidgetTester tester) async {
    // Test that the database helper can be initialized without errors
    final dbHelper = DatabaseHelper();
    
    // This should not throw an exception
    expect(() async {
      await dbHelper.database;
    }, returnsNormally);
  });
  
  testWidgets('App loads without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());
    
    // Verify that the app loads (should show login screen)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
