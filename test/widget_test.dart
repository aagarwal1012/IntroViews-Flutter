// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

// ignore: avoid_relative_lib_imports
import '../example/lib/main.dart';

const double PORTRAIT_WIDTH = 1800.0;
const double PORTRAIT_HEIGHT = 2400.0;

void main() {
  testWidgets('Dummy test', (WidgetTester tester) async {
    await tester.pumpWidget(App());
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Skip Pressed smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    expect(find.text('SKIP'), findsOneWidget);
    expect(find.text('DONE'), findsNothing);

    await tester.tap(find.text('SKIP'));
    await tester.pump();

    expect(find.text('BACK'), findsOneWidget);
    expect(find.text('DONE'), findsOneWidget);
  });

  testWidgets('Done Pressed smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    expect(find.text('SKIP'), findsOneWidget);
    expect(find.text('DONE'), findsNothing);

    // Tap the 'SKIP' button and trigger a frame.
    await tester.tap(find.text('SKIP'));
    await tester.pump();

    expect(find.text('SKIP'), findsNothing);
    expect(find.text('DONE'), findsOneWidget);

    // Tap the 'DONE' button and trigger a frame
    await tester.tap(find.text('DONE'));
    await tester.pumpAndSettle();

    // Verify that the home page opens.
    expect(find.text('DONE'), findsNothing);
    expect(find.text('This is the home page of the app'), findsOneWidget);
  });

  // Drag from first page to second and back to first.
  testWidgets('drag Reveal smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    // title of the first page should be found
    expect(find.text('Flights'), findsWidgets);
    // title of the second page should not be found
    expect(find.text('Hotels'), findsNothing);

    // drag to reveal the next page
    await tester.drag(find.byType(App), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle();

    // first page should be replaced with the second page
    expect(find.text('Flights'), findsNothing);
    expect(find.text('Hotels'), findsWidgets);

    // drag to reveal the latest page
    await tester.drag(find.byType(App), const Offset(400.0, 0.0));

    await tester.pumpAndSettle();
    // first page should be replaced with the first page
    expect(find.text('Flights'), findsWidgets);
    // title of the second page should not be found
    expect(find.text('Hotels'), findsNothing);
  });

  testWidgets('drag to a wrong direction on the first/last page does nothing',
      (WidgetTester tester) async {
    await tester.pumpWidget(App());

    // title of the first page should be found
    expect(find.text('Flights'), findsWidgets);

    // dragging right to left (previous page direction) does nothing
    await tester.drag(find.byType(App), const Offset(400.0, 0.0));
    await tester.pumpAndSettle();
    expect(find.text('Flights'), findsWidgets);

    // drag to the latest page
    await tester.drag(find.byType(App), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(App), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle();
    expect(find.text('Cabs'), findsWidgets);

    // dragging again to the next page does nothing, since it is the last page
    await tester.drag(find.byType(App), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle();

    expect(find.text('Cabs'), findsWidgets);
  });

  // Overflow condition
  testWidgets('multiple rapid clicks does not overflow',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

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

  testWidgets('should open app in portrait mode', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue =
        (const Size(PORTRAIT_WIDTH, PORTRAIT_HEIGHT));
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    // Build our app and trigger a frame in portrait mode.
    await tester.pumpWidget(App());

    expect(find.byKey(const Key('Portrait Page')), findsWidgets);
  });

  testWidgets('should throw an assert if pages list is empty', (
    WidgetTester tester,
  ) async {
    final pages = <PageViewModel>[];

    await expectLater(
      () async => await tester.pumpWidget(
        IntroViewsFlutter(pages),
      ),
      throwsA(
        isAssertionError.having(
          (AssertionError error) => error.message,
          'tapMessage',
          startsWith("At least one 'PageViewModel' item"),
        ),
      ),
    );
  });

  testWidgets('should not overflow if many bubbles', (
    WidgetTester tester,
  ) async {
    tester.binding.window.physicalSizeTestValue = const Size(500, 800);
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    final pages = List.generate(
      15,
      (index) => PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        title: Text('$index'),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (_) => IntroViewsFlutter(pages),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('SKIP button is working as intended',
      (WidgetTester tester) async {
    String? tapMessage;

    final pages = List.generate(
      3,
      (index) => PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        title: Text('Page: ${index + 1}'),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (_) => IntroViewsFlutter(
            pages,
            showSkipButton: true,
            onTapSkipButton: () {
              tapMessage = 'SKIP button clicked';
            },
          ),
        ),
      ),
    );

    expect(find.text('Page: 1'), findsWidgets);
    expect(find.text('Page: 2'), findsNothing);
    expect(find.text('Page: 3'), findsNothing);
    expect(tapMessage, isNull);

    await tester.tap(find.text('SKIP'));
    await tester.pumpAndSettle();

    expect(tapMessage, 'SKIP button clicked');
    expect(tapMessage, isNotNull);
    expect(find.text('Page: 1'), findsNothing);
    expect(find.text('Page: 2'), findsNothing);
    expect(find.text('Page: 3'), findsWidgets);
  });

  testWidgets('NEXT button is working as intended',
      (WidgetTester tester) async {
    String? tapMessage;

    final pages = List.generate(
      3,
      (index) => PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        title: Text('Page: ${index + 1}'),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (_) => IntroViewsFlutter(
            pages,
            showNextButton: true,
            showBackButton: false,
            onTapNextButton: () {
              tapMessage = 'NEXT button clicked';
            },
          ),
        ),
      ),
    );

    expect(tapMessage, isNull);
    expect(find.text('Page: 1'), findsWidgets);
    expect(find.text('Page: 2'), findsNothing);
    expect(find.text('Page: 3'), findsNothing);

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    expect(tapMessage, 'NEXT button clicked');
    expect(tapMessage, isNotNull);
    expect(find.text('Page: 1'), findsNothing);
    expect(find.text('Page: 2'), findsWidgets);
    expect(find.text('Page: 3'), findsNothing);
  });

  testWidgets('BACK button is working as intended',
      (WidgetTester tester) async {
    String? tapMessage;

    final pages = List.generate(
      4,
      (index) => PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        title: Text('Page: ${index + 1}'),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (_) => IntroViewsFlutter(
            pages,
            showBackButton: true,
            showSkipButton: true,
            showNextButton: false,
            onTapBackButton: () {
              tapMessage = 'BACK button clicked';
            },
          ),
        ),
      ),
    );

    expect(tapMessage, isNull);
    expect(find.text('Page: 1'), findsWidgets);
    expect(find.text('Page: 2'), findsNothing);
    expect(find.text('Page: 3'), findsNothing);
    expect(find.text('Page: 4'), findsNothing);

    await tester.tap(find.text('SKIP'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('BACK'));
    await tester.pumpAndSettle();

    expect(tapMessage, 'BACK button clicked');
    expect(tapMessage, isNotNull);
    expect(find.text('Page: 1'), findsNothing);
    expect(find.text('Page: 2'), findsNothing);
    expect(find.text('Page: 3'), findsWidgets);
    expect(find.text('Page: 4'), findsNothing);
  });
}
