// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction


import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';

import 'package:virtual_keyboard_custom_layout_onex/virtual_keyboard_custom_layout_onex.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getPlatformVersion test', (WidgetTester tester) async {
    // final VirtualKeyboardCustomLayoutOnex plugin = VirtualKeyboardCustomLayoutOnex();
    // final String? version = await plugin.getPlatformVersion();
    // The version string depends on the host platform running the test, so
    // just assert that some non-empty string is returned.
    // expect(version?.isNotEmpty, true);
  });
}
