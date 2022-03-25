import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:nannyplus/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('my-first-test', () {
    testWidgets('My first test', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      var drawerButton = find.byKey(const Key('drawer_button'));
      expect(drawerButton, findsOneWidget);
      await tester.tap(drawerButton);
      await tester.pumpAndSettle();
      var priceListMenu = find.byKey(const Key('price_list_menu'));
      expect(priceListMenu, findsOneWidget);
      await tester.tap(priceListMenu);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
    });
  });
}
