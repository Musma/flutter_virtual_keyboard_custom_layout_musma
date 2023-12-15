import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_keyboard_custom_layout_onex/virtual_keyboard_custom_layout_onex.dart';
import 'package:virtual_keyboard_custom_layout_onex/virtual_keyboard_custom_layout_onex_platform_interface.dart';
import 'package:virtual_keyboard_custom_layout_onex/virtual_keyboard_custom_layout_onex_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVirtualKeyboardCustomLayoutOnexPlatform
    with MockPlatformInterfaceMixin
    implements VirtualKeyboardCustomLayoutOnexPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final VirtualKeyboardCustomLayoutOnexPlatform initialPlatform = VirtualKeyboardCustomLayoutOnexPlatform.instance;

  test('$MethodChannelVirtualKeyboardCustomLayoutOnex is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVirtualKeyboardCustomLayoutOnex>());
  });

  test('getPlatformVersion', () async {
    // VirtualKeyboardCustomLayoutOnex virtualKeyboardCustomLayoutOnexPlugin = VirtualKeyboardCustomLayoutOnex();
    MockVirtualKeyboardCustomLayoutOnexPlatform fakePlatform = MockVirtualKeyboardCustomLayoutOnexPlatform();
    VirtualKeyboardCustomLayoutOnexPlatform.instance = fakePlatform;

    // expect(await virtualKeyboardCustomLayoutOnexPlugin.getPlatformVersion(), '42');
  });
}
