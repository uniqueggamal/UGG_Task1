// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:internship_task/main.dart';
import 'package:internship_task/providers/navProvider.dart';

void main() {
  testWidgets('bottom navigation changes the displayed page', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => NavProvider(),
        child: const MyApp(),
      ),
    );

    expect(find.text('Name: Ram Prassad'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.book));
    await tester.pumpAndSettle();

    expect(find.text('IT 248'), findsOneWidget);
  });
}
