import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nannyplus/widgets/bold_text.dart';

import 'utils/localizations_enabled_widget.dart';

main() {
  testWidgets(
    'BoldText should display text in bold',
    (tester) async {
      await tester.pumpWidget(
        const LocalizationsEnabledWidget(BoldText("Hello")),
      );
      await tester.pumpAndSettle();
      final pendingTotalFinder = find.byKey(const ValueKey("pending_total"));
      expect(pendingTotalFinder, findsOneWidget);
      expect(
        (pendingTotalFinder.evaluate().single.widget as Text).data,
        "47.00",
      );
    },
  );
}
