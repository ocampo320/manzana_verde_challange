import 'package:separate_api/integration_test/task/challenge_task.dart';
import 'package:separate_api/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
void mian(){

  testWidgets('validate', (WidgetTester tester)async {
    await ChallengeTask.task(tester);

  });
}