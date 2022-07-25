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
  testWidgets('Default start working test', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Project Status'), findsOneWidget);
    expect(find.byType(goalContainer), findsNWidgets(5));
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byIcon(Icons.circle), findsNWidgets(6));
    expect(find.text('Total Number Of Defects'), findsOneWidget);
    expect(find.text('Schedule feasibility'), findsOneWidget);
    expect(find.text('Design progress'), findsOneWidget);
    expect(find.text('Implementation progress'), findsOneWidget);
    expect(find.text('Integration progress'), findsOneWidget);
    // expect(find.byType(TextButton), findsOneWidget);


    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Add button working test', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());

    expect(find.byType(goalContainer), findsNWidgets(5));
    await tester.tap(find.byType(TextButton));
    await tester.pump();
    expect(find.byType(goalContainer), findsNWidgets(6));
  });

  testWidgets('Change votes sub goal risk to red', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();
    expect(find.byType(SubGoalContainer), findsNWidgets(4));
    await tester.enterText(find.byKey(const Key('subGoalVotes')).last, "99");
    await tester.pump();
    expect(find.text("99"), findsOneWidget);
    expect((tester.firstWidget(find.byKey(const Key('goalContainerColor'))) as Icon).color, Colors.red);

  });

  testWidgets('Change votes sub goal risk to green', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();
    expect(find.byType(SubGoalContainer), findsNWidgets(4));
    await tester.enterText(find.byKey(const Key('subGoalVotes')).first, "100");
    await tester.pump();
    expect(find.text("100"), findsOneWidget);
    expect((tester.firstWidget(find.byKey(const Key('goalContainerColor'))) as Icon).color, Colors.green);

  });

  testWidgets('Change votes sub goal risk to yellow', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(GFAccordion).last);
    await tester.pump();
    expect(find.byType(SubGoalContainer), findsNWidgets(4));
    await tester.enterText(find.byKey(const Key('subGoalVotes')).last, "20");
    await tester.pump();
    expect(find.text("20"), findsOneWidget);
    expect((tester.firstWidget(find.byKey(const Key('goalContainerColor'))) as Icon).color, Colors.yellow);

  });

  testWidgets('Change total risk circle to green', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();
    expect(find.byType(SubGoalContainer), findsNWidgets(4));
    await tester.enterText(find.byKey(const Key('subGoalVotes')).first, "100");
    await tester.pump();
    expect(find.text("100"), findsOneWidget);
    expect((tester.firstWidget(find.byKey(const Key('totalRiskCircle'))) as Icon).color, Colors.green);

  });

  testWidgets('Change total risk circle to yellow', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(GFAccordion).first);
    await tester.pump();
    expect(find.byType(SubGoalContainer), findsNWidgets(4));
    await tester.enterText(find.byKey(const Key('subGoalVotes')).first, "100");
    await tester.pump();
    expect(find.text("100"), findsOneWidget);
    expect((tester.firstWidget(find.byKey(const Key('totalRiskCircle'))) as Icon).color, Colors.green);
    await tester.enterText(find.byKey(const Key('subGoalVotes')).first, "10");
    await tester.pump();
    expect(find.text("10"), findsOneWidget);
    expect((tester.firstWidget(find.byKey(const Key('totalRiskCircle'))) as Icon).color, Colors.yellow);
  });

  // testWidgets('Change total risk circle to red', (WidgetTester tester) async {
  //   tester.binding.window.devicePixelRatioTestValue = 1.0;
  //   tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

  //   await tester.pumpWidget(const MyApp());

  //   await tester.tap(find.byType(GFAccordion).first);
  //   await tester.pump();
  //   expect(find.byType(SubGoalContainer), findsNWidgets(4));
  //   await tester.enterText(find.byKey(const Key('closedArrow')).last, "100");
  //   await tester.pump();
  //   expect(find.text("100"), findsOneWidget);
  //   await tester.tap(find.byType(GFAccordion).first);
  //   await tester.pump();

  //   await tester.tap(find.byType(GFAccordion).last);
  //   await tester.pump();
  //   expect(find.byType(SubGoalContainer), findsNWidgets(8));
  //   await tester.enterText(find.byKey(const Key('subGoalVotes')).last, "100");
  //   await tester.pump();
  //   expect(find.text("100"), findsNWidgets(2));
  //   await tester.tap(find.byType(GFAccordion).last);
  //   await tester.pump();

  //   await tester.tap(find.byType(GFAccordion).at(2));
  //   await tester.pump();
  //   expect(find.byType(SubGoalContainer), findsNWidgets(12));
  //   await tester.enterText(find.byKey(const Key('subGoalVotes')).last, "100");
  //   await tester.pump();
  //   expect(find.text("100"), findsNWidgets(3));
  //   await tester.tap(find.byType(GFAccordion).at(2));
  //   await tester.pump();

  // });
}