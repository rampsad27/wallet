// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:wallet_xuno/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('USD to NPR conversion integration test',
      (WidgetTester tester) async {
    //setup
    app.main();
    await tester.pumpAndSettle(); //wait to see if app ready

    // Find the widgets
    final usdField = find.byType(TextField);
    final convertButton = find.text('Convert');
    final resultText = find.text('NPR: 1336.4');

    // Enter USD amount
    //do
    await tester.enterText(usdField, '10');
    await tester.tap(convertButton);
    await tester.pumpAndSettle();

    // Verify the result
    //expect
    expect(resultText, findsOneWidget);
  });
}
