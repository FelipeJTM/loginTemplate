import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:login_template/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify main view',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      expect(find.text('iniciar'), findsOneWidget);

      // Finds the floating action button to tap on.
      final Finder textButton = find.byTooltip('Inicia sesión');

      const testKey = Key('inputUserName');
      
      //final formFinder = tester.
      //final formFinder1 = find.byValueKey('inputTextField1');

      // Emulate a tap on the floating action button.
      //await tester.enterText(textButton);

      //await tester.pumpWidget(inputUserName);
      //final Finder fab = find.byTooltip('Increment');
      await tester.enterText(find.byKey(Key("titleInput")), "title");

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      //expect(find.text('1'), findsOneWidget);
    });
  });
}
