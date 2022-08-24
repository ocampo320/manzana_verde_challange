
import 'package:flutter_test/flutter_test.dart';

import '../user_interface/interface.dart';

class ChallengeTask{
  static Future<void>task(WidgetTester tester)async {
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.tap(cartBtn);

    await tester.pumpAndSettle();
    expect(find.text('Pago'), findsOneWidget);

    // await tester.pumpAndSettle(const Duration(seconds: 3));
    // await tester.enterText(shopListProduct, 'hello');

    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.ensureVisible(btnApply);
    await tester.tap(btnApply);
  }



}