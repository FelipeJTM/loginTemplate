import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_template/pages/home.dart';

void main() {
  //this could be used to test animation and stuff like that.
  testWidgets('This is the home view', (tester) async {
    // Create the widget by telling the tester to build it.
    Widget testWidget = const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: Home(),
      ),
    );
    await tester.pumpWidget(testWidget);

    final titleFinder = find.text("other view");
    final centerFinder = find.text("Hello!");

    expect(titleFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });
}
