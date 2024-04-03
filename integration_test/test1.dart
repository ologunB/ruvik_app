import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lendo/main.dart' as app;
import 'package:lendo/views/home/search_address.dart';
import 'package:lendo/views/widgets/rev_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Run tests:', (WidgetTester tester) async {
    tester.testTextInput.register();
    app.main();
    await tester.pumpAndSettle();
    print('TEST HIDDEN DINNER');
    await createHiddenDinner(tester);
  }, semanticsEnabled: false);
}

Future<void> createHiddenDinner(WidgetTester tester) async {
  final Finder location = find.byKey(const Key('location'));
  final Finder cuisine = find.byKey(const Key('Chinese'));
  final Finder list = find.byType(ListView);
  final Finder confirm = find.byType(RevButton);
  final Finder addressField = find.byType(CupertinoTextField);

  try {
    // =========== filter.dart =============== //
    await tester.pumpAndSettle(const Duration(milliseconds: 2000));
    await tester.tap(location);
    await tester.pumpAndSettle();

    // ============== search.dart ================== //
    await tester.tap(addressField);
    await tester.enterText(addressField, 'london');
    await tester.pump();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(milliseconds: 2000));
    await tester.tap(find.byType(LocationItem).first);
    await tester.pumpAndSettle();

    // =========== filter.dart =============== //
    await tester.tap(cuisine);
    await tester.pumpAndSettle();
    await tester.drag(list, const Offset(0.0, -300));
    await tester.pumpAndSettle();
    await tester.tap(confirm);
    // =========== home.dart =============== //
    await tester.pumpAndSettle(const Duration(milliseconds: 4000));
  } catch (e) {
    print(e);
  }
}
