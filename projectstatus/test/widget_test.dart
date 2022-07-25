// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

import 'package:projectstatus/main.dart';

void main() {
  testWidgets('5 goal containers on load', (WidgetTester tester) async {
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
  });

  testWidgets('Accordion expands', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();

    expect(find.byType(SubGoalContainer), findsNWidgets(4));
  });

  testWidgets('Change description persists after accordion open & close',
      (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();

    expect(find.text("The number of defects are well below where expected"),
        findsOneWidget);

    var descInputField = find.byKey(Key("desc0"));
    await tester.enterText(descInputField, "editing desc");
    await tester.pump();
    expect(find.text("editing desc"), findsOneWidget);
    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();
    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();
    expect(find.text("editing desc"), findsOneWidget);
  });

  testWidgets('Change description persists after accordion open & close',
      (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();

    expect(find.text("The number of defects are well below where expected"),
        findsOneWidget);

    var descInputField = find.byKey(Key("desc0"));
    await tester.enterText(descInputField, "editing desc");
    await tester.pump();
    expect(find.text("editing desc"), findsOneWidget);
    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();
    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();
    expect(find.text("editing desc"), findsOneWidget);
  });
}
