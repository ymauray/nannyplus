import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:nannyplus/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('my-first-test', () {
    testWidgets('My first test', (tester) async {
      app.main();
      //await tester.pumpWidget(
      //  const MyApp(),
      //);
      await tester.pumpAndSettle();
      print("All pumped up !");
    });
  });
}
