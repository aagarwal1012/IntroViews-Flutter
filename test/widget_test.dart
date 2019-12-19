// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../example/lib/main.dart';

void main() {
  testWidgets('Skip Pressed smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new App());

    // Verify that our counter starts at 0.
    expect(find.text('SKIP'), findsOneWidget);
    expect(find.text('DONE'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.text('SKIP'));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('BACK'), findsOneWidget);
    expect(find.text('DONE'), findsOneWidget);
  });

  testWidgets('Done Pressed smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new App());

    // Verify that our counter starts at 0.
    expect(find.text('SKIP'), findsOneWidget);
    expect(find.text('DONE'), findsNothing);

    // Tap the 'SKIP' button and trigger a frame.
    await tester.tap(find.text('SKIP'));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('SKIP'), findsNothing);
    expect(find.text('DONE'), findsOneWidget);

    // Tap the 'DONE' button and trigger a frame
    await tester.tap(find.text('DONE'));
    await tester.pumpAndSettle();

    // Verify that the home page opens.
    expect(find.text('DONE'), findsNothing);
    expect(find.text('This is the home page of the app'), findsOneWidget);
  });

  // Drag from first page to second and back to first
  testWidgets('drag Reveal smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new App());

    // should find First page by its title Text
    expect(find.text('Flights'), findsWidgets);
    // second page title Text should not be found
    expect(find.text('Hotels'), findsNothing);

    // Drag Screen To Reveal next Page
    await tester.drag(find.byType(App), Offset(-400.0, 0.0));

    await tester.pumpAndSettle();

    // first page should have been removed by second page
    expect(find.text('Flights'), findsNothing);
    expect(find.text('Hotels'), findsWidgets);

    // Drag Screen To Reveal next Prev page
    await tester.drag(find.byType(App), Offset(400.0, 0.0));

    await tester.pumpAndSettle();
    // first page should have been removed by second page
    expect(find.text('Flights'), findsWidgets);
    // second page title Text should not be found
    expect(find.text('Hotels'), findsNothing);
  });

  // Overflow condition
  testWidgets('multiple rapid clicks does not overflow',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new App());

    // Verify progress buttons exists
    expect(find.text('BACK'), findsNothing);
    expect(find.text('DONE'), findsNothing);
    expect(find.text('SKIP'), findsOneWidget);
    expect(find.text('NEXT'), findsOneWidget);

    // Tap 'NEXT' beyond last frame without index out of bound
    await tester.tap(find.text('NEXT'));
    await tester.tap(find.text('NEXT'));
    await tester.tap(find.text('NEXT'));
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    expect(find.text('SKIP'), findsNothing);
    expect(find.text('NEXT'), findsNothing);
    expect(find.text('BACK'), findsOneWidget);
    expect(find.text('DONE'), findsOneWidget);

    // Tap 'BACK' beyond first frame without index out of bound
    await tester.tap(find.text('BACK'));
    await tester.tap(find.text('BACK'));
    await tester.tap(find.text('BACK'));
    await tester.tap(find.text('BACK'));
    await tester.pumpAndSettle();

    // Verify progress buttons exists
    expect(find.text('BACK'), findsNothing);
    expect(find.text('DONE'), findsNothing);
    expect(find.text('SKIP'), findsOneWidget);
    expect(find.text('NEXT'), findsOneWidget);
  });
}
