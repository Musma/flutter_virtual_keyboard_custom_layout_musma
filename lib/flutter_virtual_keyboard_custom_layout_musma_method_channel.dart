import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_virtual_keyboard_custom_layout_musma_platform_interface.dart';

/// An implementation of [VirtualKeyboardCustomLayoutOnexPlatform] that uses method channels.
class MethodChannelVirtualKeyboardCustomLayoutOnex
    extends VirtualKeyboardCustomLayoutOnexPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel('virtual_keyboard_custom_layout_onex');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
