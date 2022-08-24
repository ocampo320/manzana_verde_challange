import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:separate_api/integration_test/user_interface/interface.dart';
import 'package:separate_api/main.dart' as app;
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('challenge manzana verde',
            (tester) async {
          app.main();

          // await tester.pumpAndSettle();
          // await tester.ensureVisible(shopSection);
          //
          //
          // await tester.pumpAndSettle();
          // await tester.tap(shopSectionList);



          await tester.pumpAndSettle();
          await tester.tap(cartBtn);

          await tester.pumpAndSettle();
          expect(find.text('Pago'), findsOneWidget);

           await tester.pumpAndSettle();
           await tester.enterText(shopListProduct, 'copon');

          await tester.pumpAndSettle();
          await tester.ensureVisible(btnApply);
          await tester.tap(btnApply);








        });
  });
}