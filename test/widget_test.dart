import 'package:flutter_test/flutter_test.dart';

import 'package:quarizm_ui_task/main.dart';

void main() {
  testWidgets('Service Details', (WidgetTester tester) async {
    await tester.pumpWidget(const QuarizmUiTask());
  });
}
