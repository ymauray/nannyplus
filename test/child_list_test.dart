import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/widgets/child_list.dart';

import 'utils/localizations_enabled_widget.dart';

main() {
  testWidgets(
    'Child list displays children properly',
    (tester) async {
      final children = [
        Child(
          id: 1,
          firstName: 'John',
        ),
      ];
      await tester.pumpWidget(
        LocalizationsEnabledWidget(
          ChildList(
            children,
            47.0,
            const {1: 47.0},
          ),
        ),
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
