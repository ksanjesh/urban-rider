import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:urban_rider/main.dart';

void main() {
  testWidgets('Urban Rider app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify app title text
    expect(find.text('Urban Rider'), findsOneWidget);
  });
}
