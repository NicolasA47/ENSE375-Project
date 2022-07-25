// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

import 'package:projectstatus/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Project Status'), findsOneWidget);
    expect(find.byType(goalContainer), findsNWidgets(5));
    expect(find.byType(TextButton), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    await tester.pump();
    expect(find.byType(goalContainer), findsNWidgets(6));

    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
